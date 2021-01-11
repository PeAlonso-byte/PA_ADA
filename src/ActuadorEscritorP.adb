package body ActuadorEscritorP is
     protected body ActuadorEscritor is
      procedure iniciar is
      begin
         null;
         --he comentado en el main esperar los 260ms
         --nextTime:=Clock+salidaPeriodo;
         flagE:= 0;


      end iniciar;
               --abrir, cerrar, aumentar...
      procedure escribir(dato:ActuadorDato) is
      begin
         null;   --aqui delay until 6 decimas

         retardoE:=Ada.Real_Time.Clock+tempE;
         delay until retardoE;
         --prodPlanta:=planta;
         escribiendo:=dato;
         nextTime:=Clock+salidaPeriodo; -- Las operaciones se realizan en el timer a los 3 segundos.
         if flagE = 0 then
            Ada.Real_Time.Timing_Events.Set_Handler(salidaJitterControl, nextTime, Timer'Access);
            if escribiendo = 1 then
               Text_IO.Put_Line("Se ha mandado decrementar. Planta: " &ID'Img);
            elsif escribiendo = 0 then
              Text_IO.Put_Line("Se ha mandado incrementar. Planta: " &ID'Img);
            end if;
            flagE:=1;
         end if;

      end escribir;

      procedure Timer(event:in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         --cada 3 s
         --escribir dato escribiendo, aumentar o reducir la produccion

         if escribiendo = 1 then
            planta.decrement;
         elsif escribiendo = 0 then
            planta.increment;
         end if;
         flagE:=0;

         --considerar si hay que activar el timer o no
         --Ada.Real_Time.Timing_Events.Set_Handler(salidaJitterControl, nextTime, Timer'Access);
      end Timer;
   end ActuadorEscritor;

end ActuadorEscritorP;

