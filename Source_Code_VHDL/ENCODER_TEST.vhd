--------------------------------------------------------------------------
-- File Name    : ENCODER_TEST.vhd
-- Purpose      : GENERATE STIMULI FOR THE ENCODER
-- Author       : Mariano Basile
-- Created      : 22-Jan-2016
-- Language     : VHDL
-- Library   	: IEEE
-- Copyrigth    : Pisa University 2016. 
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY ENCODER_tb IS
END ENCODER_tb;

ARCHITECTURE ENCODER_TEST OF ENCODER_tb IS

   COMPONENT ENCODER

   port( 
   		 WORD       : in  std_logic_VECTOR (10 downto 0);
         CODEWORD   : out  std_logic_VECTOR (15 downto 0)
   );

   END COMPONENT;

   ----------------------------------------------------------------------------
   --Just a logical test, but I may need some timing info after the sysnthesis tool 
   --It's a good idea to set these timing info at this time.
   CONSTANT MckPer  :  TIME     := 200 ns;  -- Master Clk period
   CONSTANT TestLen :  INTEGER  := 24;      -- No. of Count (MckPer/2) for test


-- I N P U T     S I G N A L S

   SIGNAL   clk  : std_logic := '0';
   SIGNAL   word : std_logic_VECTOR (10 downto 0):= "00000000000";

-- O U T P U T     S I G N A L S

   SIGNAL   codeword  : std_logic_VECTOR (15 downto 0);

 -- SERVICE SIGNALS TO CREATE DATA SET OF THE TIMING
   SIGNAL clk_cycle : INTEGER;
   SIGNAL Testing: Boolean := True;

BEGIN
   -- I need first to put the design under the test
   ENCODER_ISTANCE : ENCODER PORT MAP(word,codeword);

   ----------------------------------------------------------------------------

   -- Create the clock: period of 200ns, with duty cycle of 0.5 and runs until Testing variable is true.  
      clk     <= NOT clk AFTER MckPer/2 WHEN Testing ELSE '0';
 
		  
   -- At the raising and falling edge of the clock the following process is executed
   TestingProcess: PROCESS(clk)
   VARIABLE count: INTEGER:= 0;
   BEGIN
	 --In order to obtain the clk_cycle i need to divide variable count by 2
	 --(Process is executed both at the raising and the falling edge of the clock).
     clk_cycle <= (count+1)/2;
	 
	-- Run the simulation exactly TestLen times (after clk is set to zero)
	CASE count IS
		  WHEN  3  =>  word <=  "00000000001";
		  WHEN  6   =>  word <= "00000000010";
		  WHEN  9   =>  word <= "00000000011";
		  WHEN  12   =>  word <= "00000000100";
		  WHEN  15  =>  word <= "00000000101"; 
          WHEN  18  =>  word <= "10010100100"; 
          WHEN  21 =>  word <= "11111111111"; 
          WHEN (TestLen - 1) =>   Testing <= False;
          WHEN OTHERS => NULL;
     END CASE;
     count:= count + 1;
	 
   END PROCESS TestingProcess;

END ENCODER_TEST;

