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
-- CREATED		"Sat Jun 30 12:15:06 2018"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY mips_computer IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		MemtoReg :  OUT  STD_LOGIC;
		RegDst :  OUT  STD_LOGIC;
		IorD :  OUT  STD_LOGIC;
		ALUSrcA :  OUT  STD_LOGIC;
		IRWrite :  OUT  STD_LOGIC;
		MemWrite :  OUT  STD_LOGIC;
		PCWrite :  OUT  STD_LOGIC;
		Branch :  OUT  STD_LOGIC;
		RegWrite :  OUT  STD_LOGIC;
		ADR :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALUControl :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		ALUOP :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALUOut :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALUSrcB :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		Funct :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		Op :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0);
		PC :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		PCSrc :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		ReadData :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		WriteData :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		WriteReg :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
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
		 Adr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 ALUOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 Funct : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 Op : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 pc : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 WriteData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 WriteReg : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
		 a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 wd : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 rd : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	adr_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	alucontrol_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	aluop_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	alusrca_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	alusrcb_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	branch_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	funct_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	iord_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	irwrite_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	memtoreg_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	memwrite_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	op_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	pcsrc_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	pcwrite_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	readdata_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	regdst_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	regwrite_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	writedata_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 



b2v_inst2 : datapath
PORT MAP(clk => clk,
		 IorD => iord_ALTERA_SYNTHESIZED,
		 RegDst => regdst_ALTERA_SYNTHESIZED,
		 RegWrite => regwrite_ALTERA_SYNTHESIZED,
		 ALUSrcA => alusrca_ALTERA_SYNTHESIZED,
		 Branch => branch_ALTERA_SYNTHESIZED,
		 PCWrite => pcwrite_ALTERA_SYNTHESIZED,
		 IRWrite => irwrite_ALTERA_SYNTHESIZED,
		 reset => reset,
		 MemtoReg => memtoreg_ALTERA_SYNTHESIZED,
		 ALUControl => alucontrol_ALTERA_SYNTHESIZED,
		 AluSrcB => alusrcb_ALTERA_SYNTHESIZED,
		 PCSrc => pcsrc_ALTERA_SYNTHESIZED,
		 ReadData => readdata_ALTERA_SYNTHESIZED,
		 Adr => adr_ALTERA_SYNTHESIZED,
		 ALUOut => ALUOut,
		 Funct => funct_ALTERA_SYNTHESIZED,
		 Op => op_ALTERA_SYNTHESIZED,
		 pc => PC,
		 WriteData => writedata_ALTERA_SYNTHESIZED,
		 WriteReg => WriteReg);


b2v_inst3 : aludec
PORT MAP(aluop => aluop_ALTERA_SYNTHESIZED,
		 funct => funct_ALTERA_SYNTHESIZED,
		 alucontrol => alucontrol_ALTERA_SYNTHESIZED);


b2v_inst4 : fsm
PORT MAP(clk => clk,
		 reset => reset,
		 Opcode => op_ALTERA_SYNTHESIZED,
		 MemtoReg => memtoreg_ALTERA_SYNTHESIZED,
		 RegDst => regdst_ALTERA_SYNTHESIZED,
		 IorD => iord_ALTERA_SYNTHESIZED,
		 AluSrcA => alusrca_ALTERA_SYNTHESIZED,
		 IRWrite => irwrite_ALTERA_SYNTHESIZED,
		 MemWrite => memwrite_ALTERA_SYNTHESIZED,
		 PCWrite => pcwrite_ALTERA_SYNTHESIZED,
		 Branch => branch_ALTERA_SYNTHESIZED,
		 RegWrite => regwrite_ALTERA_SYNTHESIZED,
		 ALUOp => aluop_ALTERA_SYNTHESIZED,
		 ALUSrcB => alusrcb_ALTERA_SYNTHESIZED,
		 PCSrc => pcsrc_ALTERA_SYNTHESIZED);


b2v_inst7 : imem
PORT MAP(clk => clk,
		 we => memwrite_ALTERA_SYNTHESIZED,
		 a => adr_ALTERA_SYNTHESIZED,
		 wd => writedata_ALTERA_SYNTHESIZED,
		 rd => readdata_ALTERA_SYNTHESIZED);

MemtoReg <= memtoreg_ALTERA_SYNTHESIZED;
RegDst <= regdst_ALTERA_SYNTHESIZED;
IorD <= iord_ALTERA_SYNTHESIZED;
ALUSrcA <= alusrca_ALTERA_SYNTHESIZED;
IRWrite <= irwrite_ALTERA_SYNTHESIZED;
MemWrite <= memwrite_ALTERA_SYNTHESIZED;
PCWrite <= pcwrite_ALTERA_SYNTHESIZED;
Branch <= branch_ALTERA_SYNTHESIZED;
RegWrite <= regwrite_ALTERA_SYNTHESIZED;
ADR <= adr_ALTERA_SYNTHESIZED;
ALUControl <= alucontrol_ALTERA_SYNTHESIZED;
ALUOP <= aluop_ALTERA_SYNTHESIZED;
ALUSrcB <= alusrcb_ALTERA_SYNTHESIZED;
Funct <= funct_ALTERA_SYNTHESIZED;
Op <= op_ALTERA_SYNTHESIZED;
PCSrc <= pcsrc_ALTERA_SYNTHESIZED;
ReadData <= readdata_ALTERA_SYNTHESIZED;
WriteData <= writedata_ALTERA_SYNTHESIZED;

END bdf_type;