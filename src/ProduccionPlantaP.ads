with System;
package ProduccionPlantaP is
   type SensorDato is new Integer;
   protected type produccionPlanta is
      function readPlanta return SensorDato;
      procedure increment;
      procedure decrement;
   private
      prodPlanta:SensorDato:=15;
   end produccionPlanta;
end ProduccionPlantaP;

