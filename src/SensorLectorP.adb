package body SensorLectorP is
      protected body SensorLector is
      procedure iniciar is --arranca el temporizador una vez haya pasado un intervalo de tiempo
      begin
         datoDisponible:=False;
         nextTime:=Clock+entradaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end iniciar;

      entry leer(dato:out SensorDato)
        when datoDisponible is
      begin

         dato:=leyendo;
         datoDisponible:=False;
         --Text_IO.Put_Line("Leer");
      end leer;

      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --obtener el dato y cargarlo en leyendo
         --hacer delay until para 15 decimas, independiente con las otras plantas
         retardoS:=Ada.Real_Time.Clock+tempS;
         delay until retardoS;

         leyendo:= planta.readPlanta; -- cargamos el dato en leyendo

         datoDisponible:=True;
         nextTime:=nextTime+entradaMedicion; -- Para que una vez que entre, se hagan las lecturas cada segundo.
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end Timer;

   end SensorLector;
end SensorLectorP;


