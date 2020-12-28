with System;
package ProduccionPlantaP is

   protected type produccionPlanta is
      function readPlanta return Integer;
      procedure increment;
      procedure decrement;
   private
      prodPlanta:Integer:=15;
   end produccionPlanta;
end ProduccionPlantaP;

