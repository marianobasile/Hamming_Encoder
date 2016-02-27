--------------------------------------------------------------------------
-- File Name    : ENCODER.vhd
-- Purpose      : HAMMING ERROR-CORRECTING-CODE ENCODER
-- Author       : Mariano Basile
-- Created      : 22-Jan-2016
-- Language     : VHDL
-- Library   	: IEEE
-- Copyrigth    : Pisa University 2016. 
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY ENCODER is
   
   port( 
   		 WORD       : in  std_logic_VECTOR (10 downto 0);
         CODEWORD   : out  std_logic_VECTOR (15 downto 0)
   );
		 
END ENCODER;

-- Describing funtionality by a process()
ARCHITECTURE BEHAVIOURAL OF ENCODER IS
BEGIN
	ENCODING:process(WORD)
	variable P1,P2,P4,P8,PO:std_logic;
	begin
		--Computing parity bits Pi i=1,2,4,8. 
		P1:= WORD(0) XOR WORD(1) XOR WORD(3) XOR WORD(4) XOR WORD(6) XOR WORD(8) XOR WORD(10);
		
		P2:= WORD(0) XOR WORD(2) XOR WORD(3) XOR WORD(5) XOR WORD(6) XOR WORD(9) XOR WORD(10);
		
		P4:= WORD(1) XOR WORD(2) XOR WORD(3) XOR WORD(7) XOR WORD(8) XOR WORD(9) XOR WORD(10);
		
		P8:= WORD(4) XOR WORD(5) XOR WORD(6) XOR WORD(7) XOR WORD(8) XOR WORD(9) XOR WORD(10);
		
		--Another parity bit PO (code's distance equals to 4) obtained by applying EXCLUSIVE OR 
		--beetween all bits(data and parity ones).
		PO:= P1 XOR P2 XOR WORD(0) XOR P4 XOR WORD(1) XOR WORD(2) XOR WORD(3) XOR P8 XOR WORD(4) 
		XOR WORD(5) XOR WORD(6) XOR WORD(7) XOR WORD(8) XOR WORD(9) XOR WORD(10);
		
		--Defining output
		CODEWORD <= PO & WORD(10) & WORD(9) & WORD(8) & WORD(7) & WORD(6) & WORD(5) &
					WORD(4) & P8 & WORD(3) & WORD(2) & WORD(1) & P4 & WORD(0) & P2 & P1;
		
	end process ENCODING;
END BEHAVIOURAL;