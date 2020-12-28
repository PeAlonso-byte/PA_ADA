package body ActuadorEscritorP is
     protected body ActuadorEscritor is
      procedure iniciar is
      begin
         null;
         --he comentado en el main esperar los 260ms
         nextTime:=Clock+salidaPeriodo;
      end iniciar;
               --abrir, cerrar, aumentar...
      procedure escribir(dato:ActuadorDato) is
      begin
         null;   --aqui delay until 6 decimas
         escribiendo:=dato;
         nextTime:=Clock+salidaPeriodo;
         Ada.Real_Time.Timing_Events.Set_Handler(salidaJitterControl, nextTime, Timer'Access);
         Text_IO.Put_Line("Escribir");
      end escribir;

      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --cada 3 s
         --escribir dato escribiendo, aumentar o reducir la produccion
         nextTime:=nextTime+salidaPeriodo;
         --considerar si hay que activar el timer o no
         Ada.Real_Time.Timing_Events.Set_Handler(salidaJitterControl, nextTime, Timer'Access);
      end Timer;
   end ActuadorEscritor;

end ActuadorEscritorP;

