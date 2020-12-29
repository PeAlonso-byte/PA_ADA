with Text_IO;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
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
   task type tareaPlanta is
      entry leer(datoEntrada:out SensorDato);
      entry escribir(datoSalida:ActuadorDato);
   end tareaPlanta;

   task body tareaPlanta is  --crear 3 instancias

      flagEscribir:Integer:=0;
      tempPlanta:ActuadorDato;
      contadorProduccion: aliased produccionPlanta;
      entrada:SensorLector(contadorProduccion'Access); --cada planta
      salida:ActuadorEscritor(contadorProduccion'Access);
   begin
      entrada.iniciar;
      loop
         select
            accept leer(datoEntrada:out SensorDato) do
               --no hacer el delay aqui dentro,hacerlo fuera del end select
               --hacer aqui lo minimo posible
               entrada.leer(datoEntrada);
               --devolver el dato
            end leer;
         or
            accept escribir(datoSalida:ActuadorDato) do
               flagEscribir:=1; -- Guardamos el flag y escribimos fuera del select para asi no bloquear el algoritmo de control durante 1.8s ya que tenemos que leer cada 1s
               tempPlanta:=datoSalida;
            end escribir;
         end select;

         if flagEscribir = 1 then
            flagEscribir:=0;
            salida.escribir(tempPlanta);
         end if;

      end loop;
   end tareaPlanta;

   maxConsumoCiudad: constant integer:=90;
   minConsumoCiudad: constant integer:=15;
   consumoCiudad:SensorDato:=35; -- Creamos el consumo de la ciudad que irá variando con el tiempo, de forma aleatoria.

   task type AlgoritmoControl(pl1:access tareaPlanta;pl2:access tareaPlanta;pl3:access tareaPlanta);
   task body AlgoritmoControl is
      datoEntrada:SensorDato;
      datoSalida:ActuadorDato;
      consumoTotalPlantas:SensorDato:=0;
      porcentajeDiff:SensorDato:=0;
      consumoDiff:SensorDato:=0;
      retardoA:Ada.Real_Time.Time;
      tempA:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(1000);
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
         porcentajeDiff:= ((consumoCiudad/consumoTotalPlantas) * 100) - 100;
         consumoDiff:= consumoCiudad - consumoTotalPlantas;

         if porcentajeDiff > 5 then
            Text_IO.Put_Line("PELIGRO SOBRECARGA ! - CONSUMO: " & consumoCiudad'Img & " PRODUCCION: " &consumoTotalPlantas'Img);
         elsif porcentajeDiff < -5 then
            Text_IO.Put_Line("PELIGRO SOBRECARGA ! - CONSUMO: " & consumoCiudad'Img & " PRODUCCION: " &consumoTotalPlantas'Img);
         else
            Text_IO.Put_Line("ESTABLE - CONSUMO: " & consumoCiudad'Img & " PRODUCCION: " &consumoTotalPlantas'Img);
         end if;

         if consumoDiff > 0 then
            datoSalida:=0; -- Si datoSalida = 0 quiere decir incrementar
         elsif consumoDiff < 0 then
            datoSalida:=1; -- Si datoSalida = 0 quiere decir decrementar
         end if;

         if consumoDiff >= 3 then
            pl1.escribir(datoSalida);
            Text_IO.Put_Line("INCREMENTANDO PRODUCCION PLANTA 1");
            pl2.escribir(datoSalida);
            Text_IO.Put_Line("INCREMENTANDO PRODUCCION PLANTA 2");
            pl3.escribir(datoSalida);
            Text_IO.Put_Line("INCREMENTANDO PRODUCCION PLANTA 3");
         elsif consumoDiff = 2 then
            pl1.escribir(datoSalida);
            Text_IO.Put_Line("INCREMENTANDO PRODUCCION PLANTA 1");
            pl2.escribir(datoSalida);
            Text_IO.Put_Line("INCREMENTANDO PRODUCCION PLANTA 2");
         elsif consumoDiff = 1 then
            pl1.escribir(datoSalida);
            Text_IO.Put_Line("DECREMENTANDO PRODUCCION PLANTA 1");
         elsif consumoDiff <= -3 then
            pl1.escribir(datoSalida);
            Text_IO.Put_Line("DECREMENTANDO PRODUCCION PLANTA 1");
            pl2.escribir(datoSalida);
            Text_IO.Put_Line("DECREMENTANDO PRODUCCION PLANTA 2");
            pl3.escribir(datoSalida);
            Text_IO.Put_Line("DECREMENTANDO PRODUCCION PLANTA 3");
         elsif consumoDiff = -2 then
            pl1.escribir(datoSalida);
            Text_IO.Put_Line("DECREMENTANDO PRODUCCION PLANTA 1");
            pl2.escribir(datoSalida);
            Text_IO.Put_Line("DECREMENTANDO PRODUCCION PLANTA 2");
         elsif consumoDiff = -1 then
            pl1.escribir(datoSalida);
            Text_IO.Put_Line("DECREMENTANDO PRODUCCION PLANTA 1");
         end if;
         retardoA:= Ada.Real_Time.Clock+tempA; -- Se añade un retardo a la tarea control para que se ejecute cada 1s
	 delay until retardoA;

         --procesar datos

      end loop;
   end AlgoritmoControl;


   planta1:aliased tareaPlanta; -- Utilizamos aliased para asi obtener la referencia a la variable posteriormente mediante Access.
   planta2:aliased tareaPlanta;
   planta3:aliased tareaPlanta;

   control:AlgoritmoControl(planta1'Access, planta2'Access, planta3'Access);



begin
   --  Insert code here.
   null;
end Main;



