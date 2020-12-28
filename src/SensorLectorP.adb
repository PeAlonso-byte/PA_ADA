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
         Text_IO.Put_Line("Leer");
      end leer;

      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --obtener el dato y cargarlo en leyendo
         --hacer delay until para 15 decimas, independiente con las otras plantas
         datoDisponible:=True;
         nextTime:=nextTime+entradaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end Timer;

   end SensorLector;
end SensorLectorP;


