----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:55:50 07/19/2021 
-- Design Name: 
-- Module Name:    mic_column_bytes - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mix_column32bytes is
    Port ( data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end mix_column32bytes;

architecture Behavioral of mix_column32bytes is

-- signal declaration of required temporary variables for storing and divisiona nd shifting of data.
signal temp1, temp2, temp3, temp4, s_temp1, s_temp2, s_temp3, s_temp4 : std_logic_vector(7 downto 0);

begin
	
	-- Division of row data of 32 bits into bytes
	temp1 <= data_in(31 downto 24);
	temp2 <= data_in(23 downto 16);
	temp3 <= data_in(15 downto 8);
	temp3 <= data_in(7 downto 0 );
	
	-- shifting of data
--	s_temp1 <= temp1 sll 1;
--	s_temp2 <= temp2 sll 1;
--	s_temp3 <= temp3 sll 1;
--	s_temp4 <= temp4 sll 1;

	s_temp1 <= temp1 (6 downto 0) & '0' ;
	s_temp2 <= temp2 (6 downto 0) & '0' ;
	s_temp3 <= temp3  (6 downto 0) & '0' ;
	s_temp4 <= temp4  (6 downto 0) & '0' ;
	
	-- Assingning multiplited data to output variable
	-- Here the in the case of matrix multiplication the left shift the data w.r.t the matrix
	-- And the addition is the XOR operation of the two 8-bit binary numbers
	
	data_out(31 downto 24) <= s_temp1  xor s_temp2 xor temp2  xor temp3 xor temp4;
	data_out(23 downto 16) <= temp1 xor s_temp2 xor s_temp3 xor temp3  xor temp4;
	data_out(15 downto 8) <= temp1 xor temp2 xor s_temp3   xor s_temp4 xor temp4 ;
	data_out(7 downto 0) <= s_temp1  xor temp1 xor temp2 xor temp3 xor s_temp4 ;
	

end Behavioral;
