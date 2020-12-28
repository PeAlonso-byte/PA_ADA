with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Text_IO;
with ProduccionPlantaP;
use ProduccionPlantaP;
package ActuadorEscritorP is
   type ActuadorDato is new Integer;
   protected type ActuadorEscritor(planta: access produccionPlanta) is

      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure iniciar;
      procedure escribir(dato:ActuadorDato);
      procedure Timer(event: in out Ada.Real_Time.Timing_Events.Timing_Event);
   private
      nextTime:Ada.Real_Time.Time;
      escribiendo:ActuadorDato;
               salidaJitterControl:Ada.Real_Time.Timing_Events.Timing_Event;
     --300ms -40 ms del output jitter
      salidaPeriodo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(3000);
      retardoE:Ada.Real_Time.Time;
      tempE:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(600);
      flagE:Integer:=0;
      prodPlanta: produccionPlanta;
   end ActuadorEscritor;

end ActuadorEscritorP;

