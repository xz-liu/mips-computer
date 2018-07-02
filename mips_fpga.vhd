-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition"
-- CREATED		"Mon Jul 02 20:50:46 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY mips_fpga IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		clk_dt :  IN  STD_LOGIC;
		data :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		sel :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		state :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END mips_fpga;

ARCHITECTURE bdf_type OF mips_fpga IS 

COMPONENT digtube
GENERIC (wid : INTEGER
			);
	PORT(		clk, reset, en : in std_logic;
	data : in std_logic_vector(wid*4-1 downto 0);
	dt_sel : out std_logic_vector(wid-1 downto 0);
	dt_data : out std_logic_vector(7 downto 0)
	);
END COMPONENT;

COMPONENT mips_computer
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 MemtoReg : OUT STD_LOGIC;
		 RegDst : OUT STD_LOGIC;
		 IorD : OUT STD_LOGIC;
		 ALUSrcA : OUT STD_LOGIC;
		 IRWrite : OUT STD_LOGIC;
		 MemWrite : OUT STD_LOGIC;
		 PCWrite : OUT STD_LOGIC;
		 Branch : OUT STD_LOGIC;
		 RegWrite : OUT STD_LOGIC;
		 ADR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ALUControl : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 ALUOP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 ALUOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ALUSrcB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 Funct : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 Instr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 Op : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 PCJump : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 PCSrc : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 RDCLK : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ReadData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 RFRD1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 RFRD2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 StateNow : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 WriteData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 WriteReg : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	WD :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;


BEGIN 



b2v_dt : digtube
GENERIC MAP(wid => 6
			)
PORT MAP(clk => clk_dt,
		 reset => SYNTHESIZED_WIRE_3,
		 en => SYNTHESIZED_WIRE_1,
		 data => WD(23 DOWNTO 0),
		 dt_data => data,
		 dt_sel => sel);


SYNTHESIZED_WIRE_3 <= NOT(reset);



b2v_inst1 : mips_computer
PORT MAP(clk => clk,
		 reset => SYNTHESIZED_WIRE_3,
		 MemWrite => SYNTHESIZED_WIRE_1,
		 StateNow => state,
		 WriteData => WD);


END bdf_type;