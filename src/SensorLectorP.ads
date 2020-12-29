with System;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Real_Time.Timing_Events;
use Ada.Real_Time;
with Text_IO;
with ProduccionPlantaP;
use ProduccionPlantaP;
package SensorLectorP is
   protected type SensorLector(planta: access produccionPlanta) is
      pragma Interrupt_Priority(System.Interrupt_Priority'Last);
      procedure iniciar;
      entry leer(dato:out SensorDato);
      procedure Timer(event: in out Ada.Real_Time.Timing_Events.Timing_Event);
   private
      nextTime:Ada.Real_Time.Time;
      leyendo:SensorDato;
      datoDisponible:Boolean:=True;
      prodPlanta: produccionPlanta;
           entradaJitterControl:Ada.Real_Time.Timing_Events.Timing_Event;
     --400ms -20ms del input jitter
      entradaPeriodo:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(300);
      entradaMedicion:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(1000);
      retardoS:Ada.Real_Time.Time;
      tempS:Ada.Real_Time.Time_Span:=Ada.Real_Time.Milliseconds(15);

   end SensorLector;
end SensorLectorP;

