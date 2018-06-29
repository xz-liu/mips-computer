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
-- CREATED		"Fri Jun 29 20:38:14 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY mips_computer IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		PC :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		WriteData :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END mips_computer;

ARCHITECTURE bdf_type OF mips_computer IS 

COMPONENT datapath
	PORT(clk : IN STD_LOGIC;
		 IorD : IN STD_LOGIC;
		 RegDst : IN STD_LOGIC;
		 RegWrite : IN STD_LOGIC;
		 ALUSrcA : IN STD_LOGIC;
		 Branch : IN STD_LOGIC;
		 PCWrite : IN STD_LOGIC;
		 IRWrite : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 MemtoReg : IN STD_LOGIC;
		 ALUControl : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 AluSrcB : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 PCSrc : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 ReadData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 Adr : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 Funct : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 Op : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 pc : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 WriteData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT aludec
	PORT(aluop : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 funct : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 alucontrol : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT fsm
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 Opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 MemtoReg : OUT STD_LOGIC;
		 RegDst : OUT STD_LOGIC;
		 IorD : OUT STD_LOGIC;
		 AluSrcA : OUT STD_LOGIC;
		 IRWrite : OUT STD_LOGIC;
		 MemWrite : OUT STD_LOGIC;
		 PCWrite : OUT STD_LOGIC;
		 Branch : OUT STD_LOGIC;
		 RegWrite : OUT STD_LOGIC;
		 ALUOp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 ALUSrcB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 PCSrc : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT imem
	PORT(clk : IN STD_LOGIC;
		 we : IN STD_LOGIC;
		 a : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 wd : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rd : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	adr :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	alucontrol :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	aluop :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	alusrca :  STD_LOGIC;
SIGNAL	alusrcb :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	branch :  STD_LOGIC;
SIGNAL	funct :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	iord :  STD_LOGIC;
SIGNAL	irwrite :  STD_LOGIC;
SIGNAL	memtoreg :  STD_LOGIC;
SIGNAL	memwrite :  STD_LOGIC;
SIGNAL	op :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	pcsrc :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	pcwrite :  STD_LOGIC;
SIGNAL	readdata :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	regdst :  STD_LOGIC;
SIGNAL	regwrite :  STD_LOGIC;
SIGNAL	writedata_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 



b2v_inst : datapath
PORT MAP(clk => clk,
		 IorD => iord,
		 RegDst => regdst,
		 RegWrite => regwrite,
		 ALUSrcA => alusrca,
		 Branch => branch,
		 PCWrite => pcwrite,
		 IRWrite => irwrite,
		 reset => reset,
		 MemtoReg => memtoreg,
		 ALUControl => alucontrol,
		 AluSrcB => alusrcb,
		 PCSrc => pcsrc,
		 ReadData => readdata,
		 Adr => adr,
		 Funct => funct,
		 Op => op,
		 pc => PC,
		 WriteData => writedata_ALTERA_SYNTHESIZED);


b2v_inst3 : aludec
PORT MAP(aluop => aluop,
		 funct => funct,
		 alucontrol => alucontrol);


b2v_inst4 : fsm
PORT MAP(clk => clk,
		 reset => reset,
		 Opcode => op,
		 MemtoReg => memtoreg,
		 RegDst => regdst,
		 IorD => iord,
		 AluSrcA => alusrca,
		 IRWrite => irwrite,
		 MemWrite => memwrite,
		 PCWrite => pcwrite,
		 Branch => branch,
		 RegWrite => regwrite,
		 ALUOp => aluop,
		 ALUSrcB => alusrcb,
		 PCSrc => pcsrc);


b2v_inst5 : imem
PORT MAP(clk => clk,
		 we => memwrite,
		 a => adr,
		 wd => writedata_ALTERA_SYNTHESIZED,
		 rd => readdata);

WriteData <= writedata_ALTERA_SYNTHESIZED;

END bdf_type;