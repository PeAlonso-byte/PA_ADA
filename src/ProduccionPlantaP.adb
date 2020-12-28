package body ProduccionPlantaP is
      protected body produccionPlanta is
      function readPlanta return Integer is
      begin
         return prodPlanta;
      end readPlanta;

      procedure increment is
      begin
         prodPlanta:=prodPlanta+1;
      end increment;

      procedure decrement is
      begin
         prodPlanta:=prodPlanta-1;
      end decrement;

   end produccionPlanta;
end SensorLectorP;


