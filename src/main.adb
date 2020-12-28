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

--ALGORITMO DE CONTROL

procedure Main is
   task type tareaPlanta is
      entry leer(datoEntrada:out SensorDato);
      entry escribir(datoSalida:ActuadorDato);
   end tareaPlanta;

   task body tareaPlanta is  --crear 3 instancias
      entrada:SensorLector; --cada planta
      salida:ActuadorEscritor;
      flagEscribir:Integer:=0;
      tempPlanta:ActuadorDato;
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

   task type AlgoritmoControl(pl1:access tareaPlanta;pl2:access tareaPlanta;pl3:access tareaPlanta);
   task body AlgoritmoControl is
      datoEntrada:SensorDato;
      datoSalida:ActuadorDato;
   begin
      loop
         pl1.leer(datoEntrada);
         --procesar datos
         pl1.escribir(datoSalida);
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



