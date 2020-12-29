with Text_IO;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
with Ada.Numerics.Discrete_Random;
with System;
use Ada.Real_Time;
use Ada.Real_Time.Timing_Events;
with SensorLectorP;
use SensorLectorP;
with ActuadorEscritorP;
use ActuadorEscritorP;
with ProduccionPlantaP;
use ProduccionPlantaP;

--ALGORITMO DE CONTROL

procedure Main is
   task type tareaPlanta (ID: Integer) is
      entry leer(datoEntrada:out SensorDato);
      entry escribir(datoSalida:ActuadorDato);
   end tareaPlanta;

   -- NUMEROS ALEATORIOS.

   subtype aleatorioReactor is Integer range 1..3;
   package Aleatorio is new Ada.Numerics.Discrete_Random(aleatorioReactor);
   seedR: Aleatorio.Generator;

   subtype aleatorioCiudad is Integer range -3..3;
   package AleatorioC is new Ada.Numerics.Discrete_Random(aleatorioCiudad);
   seedC: AleatorioC.Generator;

   --FIN NUMEROS ALEATORIOS.
   task body tareaPlanta is  --crear 3 instancias

      flagEscribir:Integer:=0;
      tempPlanta:ActuadorDato;
      contadorProduccion: aliased produccionPlanta;
      entrada:SensorLector(contadorProduccion'Access); --cada planta
      salida:ActuadorEscritor(contadorProduccion'Access, ID);
      --lastMes:Ada.Real_Time.Time;
      --tempMes:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(5000);
   begin
      entrada.iniciar;
      loop
         select

            accept leer(datoEntrada:out SensorDato) do
               --no hacer el delay aqui dentro,hacerlo fuera del end select
               --hacer aqui lo minimo posible
               entrada.leer(datoEntrada);
               --lastMes:=Ada.Real_Time.Clock;
               --devolver el dato
            end leer;
         or
            accept escribir(datoSalida:ActuadorDato) do
               flagEscribir:=1; -- Guardamos el flag y escribimos fuera del select para asi no bloquear el algoritmo de control durante 1.8s ya que tenemos que leer cada 1s
               tempPlanta:=datoSalida;
               --lastMes:=Ada.Real_Time.Clock;
            end escribir;
         end select;

         if flagEscribir = 1 then
            flagEscribir:=0;
            if contadorProduccion.readPlanta > 0 and then contadorProduccion.readPlanta < 30 then
               salida.escribir(tempPlanta);
            else
               Text_IO.Put_Line("La planta: " &ID'Img & "No puede variar la produccion. Valor actual: " &contadorProduccion.readPlanta'Img);
            end if;

         end if;
         --delay until lastMes+tempMes;
	 --Text_IO.Put_Line("Alerta MONITORIZACION");
      end loop;
   end tareaPlanta;

   maxConsumoCiudad: constant SensorDato:=90;
   minConsumoCiudad: constant SensorDato:=15;
   consumoCiudad:SensorDato:=15; -- Creamos el consumo de la ciudad que irá variando con el tiempo, de forma aleatoria.

   task type ControlCiudad;
   task body ControlCiudad is
      tempCiudad:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(6000);
      tempConsumo:SensorDato;
      varConsumo:Integer;
      tempV:SensorDato;
   begin
      loop
         delay until Ada.Real_Time.Clock+tempCiudad;
         AleatorioC.Reset(seedC);
         varConsumo:=AleatorioC.Random(seedC);
         tempV:= SensorDato(varConsumo);
         tempConsumo:=consumoCiudad+tempV;

         if tempConsumo <= maxConsumoCiudad and then tempConsumo >=minConsumoCiudad then
            consumoCiudad:=consumoCiudad+tempV;
         else
            Text_IO.Put_Line("La produccion de la ciudad es superior o inferior al límite [15-90]");
         end if;

      end loop;
      end ControlCiudad;

   task type AlgoritmoControl(pl1:access tareaPlanta;pl2:access tareaPlanta;pl3:access tareaPlanta);
   task body AlgoritmoControl is
      datoEntrada:SensorDato;
      datoSalida:ActuadorDato;
      consumoTotalPlantas:SensorDato:=0;
      porcentajeDiff:Float;
      consumoDiff:SensorDato:=0;
      retardoA:Ada.Real_Time.Time;
      tempA:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(1000);
      temp1:Float;
      temp2:Float;
      temp3:Float;
      tempPlanta:Integer;
   begin
      loop
         consumoTotalPlantas:=0;

         pl1.leer(datoEntrada);
         consumoTotalPlantas:=consumoTotalPlantas + datoEntrada;

         pl2.leer(datoEntrada);
         consumoTotalPlantas:=consumoTotalPlantas + datoEntrada;

         pl3.leer(datoEntrada);
         consumoTotalPlantas:=consumoTotalPlantas + datoEntrada;

         -- Calculamos el porcentaje.
         temp1 := Float(consumoCiudad);
         temp2 := Float(consumoTotalPlantas);
         temp3 := ((temp1/temp2) * 100.0) - 100.0;

         porcentajeDiff:= temp3;
         consumoDiff:= consumoCiudad - consumoTotalPlantas;

	 if consumoDiff > 0 then
            datoSalida:=0; -- Si datoSalida = 0 quiere decir incrementar
         elsif consumoDiff < 0 then
            datoSalida:=1; -- Si datoSalida = 0 quiere decir decrementar
         else
            datoSalida:=-1;
         end if;


         if porcentajeDiff > 5.0 then
            Text_IO.Put_Line("PELIGRO BAJADA ! - CONSUMO: " & consumoCiudad'Img & " PRODUCCION: " &consumoTotalPlantas'Img);
            if consumoDiff >= 3 then
               -- Hay que actuar sobre todas las plantas
            	pl1.escribir(datoSalida);
            	pl2.escribir(datoSalida);
            	pl3.escribir(datoSalida);
            elsif consumoDiff = 2 then
               -- Elegimos dos plantas aleatorias.
               Aleatorio.Reset(seedR);
               tempPlanta:=Aleatorio.Random(seedR);
               if tempPlanta = 1 then
                  pl1.escribir(datoSalida);
               elsif tempPlanta = 2 then
                  pl2.escribir(datoSalida);
               else
                  pl3.escribir(datoSalida);
               end if;

               Aleatorio.Reset(seedR);
               tempPlanta:=Aleatorio.Random(seedR);
               if tempPlanta = 1 then
                  pl1.escribir(datoSalida);
               elsif tempPlanta = 2 then
                  pl2.escribir(datoSalida);
               else
                  pl3.escribir(datoSalida);
               end if;
            elsif consumoDiff = 1 then
               -- Elegimos una planta aleatoria.
            	Aleatorio.Reset(seedR);
               tempPlanta:=Aleatorio.Random(seedR);
               if tempPlanta = 1 then
                  pl1.escribir(datoSalida);
               elsif tempPlanta = 2 then
                  pl2.escribir(datoSalida);
               else
                  pl3.escribir(datoSalida);
               end if;
            end if;

         elsif porcentajeDiff < -5.0 then
            Text_IO.Put_Line("PELIGRO SOBRECARGA ! - CONSUMO: " & consumoCiudad'Img & " PRODUCCION: " &consumoTotalPlantas'Img);
            if consumoDiff <= -3 then
               -- Hay que actuar en todas las centrales.
            	pl1.escribir(datoSalida);
            	pl2.escribir(datoSalida);
            	pl3.escribir(datoSalida);
            elsif consumoDiff = -2 then
               -- Decrementamos dos plantas aleatorias. Se puede hacer mejor sin tener que repetir codigo.
               Aleatorio.Reset(seedR);
               tempPlanta:=Aleatorio.Random(seedR);
               if tempPlanta = 1 then
                  pl1.escribir(datoSalida);
               elsif tempPlanta = 2 then
                  pl2.escribir(datoSalida);
               else
                  pl3.escribir(datoSalida);
               end if;

               Aleatorio.Reset(seedR);
               tempPlanta:=Aleatorio.Random(seedR);
               if tempPlanta = 1 then
                  pl1.escribir(datoSalida);
               elsif tempPlanta = 2 then
                  pl2.escribir(datoSalida);
               else
                  pl3.escribir(datoSalida);
               end if;

            elsif consumoDiff = -1 then
               -- Decrementamos una planta aleatoria.
               Aleatorio.Reset(seedR);
               tempPlanta:=Aleatorio.Random(seedR);
               if tempPlanta = 1 then
                  pl1.escribir(datoSalida);
               elsif tempPlanta = 2 then
                  pl2.escribir(datoSalida);
               else
                  pl3.escribir(datoSalida);
               end if;
            end if;
         else
            Text_IO.Put_Line("ESTABLE - CONSUMO: " & consumoCiudad'Img & " PRODUCCION: " &consumoTotalPlantas'Img);
         end if;

         retardoA:= Ada.Real_Time.Clock+tempA; -- Se añade un retardo a la tarea control para que se ejecute cada 1s
	 delay until retardoA;

         --procesar datos

      end loop;
   end AlgoritmoControl;


   planta1:aliased tareaPlanta(1); -- Utilizamos aliased para asi obtener la referencia a la variable posteriormente mediante Access.
   planta2:aliased tareaPlanta(2);
   planta3:aliased tareaPlanta(3);

   control:AlgoritmoControl(planta1'Access, planta2'Access, planta3'Access);
   controlCi:ControlCiudad;


begin
   --  Insert code here.
   null;
end Main;



