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
                salida.escribir(datoSalida);
            end escribir;
            --delay 6 decimas salida.escribir(datoSalida);
         end select;
      end loop;
   end tareaPlanta;

   --3 instancias, cada una 1 planta
   t:tareaPlanta;
   t2:tareaPlanta;
   t3:tareaPlanta;

   task type AlgoritmoControl(entrada:access SensorLector; salida:access ActuadorEscritor);
   task body AlgoritmoControl is
      datoEntrada:SensorDato;
      datoSalida:ActuadorDato;
   begin
      loop
         t.leer(datoEntrada);
         --procesar datos
         t.escribir(datoSalida);
      end loop;
   end AlgoritmoControl;


   sl:aliased SensorLector;
   ae:aliased  ActuadorEscritor;
   control:AlgoritmoControl(sl'Access, ae'Access);
begin
   --  Insert code here.
   null;
end Main;



