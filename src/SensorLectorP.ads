with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Text_IO;
package SensorLectorP is
   type SensorDato is new Integer;
   protected type SensorLector is


      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure iniciar;
      entry leer(dato:out SensorDato);
      procedure Timer(event: in out Ada.Real_Time.Timing_Events.Timing_Event);
   private
      nextTime:Ada.Real_Time.Time;
      leyendo:SensorDato;
      datoDisponible:Boolean:=True;

           entradaJitterControl:Ada.Real_Time.Timing_Events.Timing_Event;
     --400ms -20ms del input jitter
     entradaPeriodo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(380);

   end SensorLector;
end SensorLectorP;

