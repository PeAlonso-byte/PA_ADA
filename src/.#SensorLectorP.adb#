package body SensorLectorP is
      protected body SensorLector is
      procedure iniciar is --arranca el temporizador una vez haya pasado un intervalo de tiempo
      begin
         datoDisponible:=False;
         nextTime:=Clock+entradaPeriodo;
         --para que se ejecute el timer por primera vez 0.3 s
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end iniciar;

      entry leer(dato:out SensorDato) --se ejecuta cuando hay un datoDisponible
        when datoDisponible is        --datoDisponible:=True, cuando se activa el temporizador
      begin

         dato:=leyendo; --devuelvo el dato almacenado en leyendo
         datoDisponible:=False;  --indico que ya no tengo mas disponibles
         --Text_IO.Put_Line("Leer");
      end leer;

      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --obtener el dato de objeto protegido y cargarlo en leyendo
         --hacer delay until para 15 decimas, independiente con las otras plantas
         --tardamos 15 s en leer
         retardoS:=Ada.Real_Time.Clock+tempS;
         delay until retardoS;

         leyendo:= planta.readPlanta; -- cargamos el dato en leyendo

         datoDisponible:=True;  --dejamos el dato cargado y indicamos que hay un dato disponible
         nextTime:=nextTime+entradaMedicion; -- Para que una vez que entre, se hagan las lecturas cada segundo.
         --cada 1 s un dato disponible (cada 1s se activa timer)
         Ada.Real_Time.Timing_Events.Set_Handler(entradaJitterControl, nextTime, Timer'Access);
      end Timer;

   end SensorLector;
end SensorLectorP;


