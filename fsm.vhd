library IEEE; use IEEE.STD_LOGIC_1164.all;

entity fsm is -- finite state machine
    port(clk,reset		:in std_logic;
		Opcode			:in std_logic_vector(5 downto 0);
		MemtoReg,RegDst	:out std_logic;
		IorD			:out std_logic;
		ALUSrcB,PCSrc	:out std_logic_vector(1 downto 0);
		AluSrcA,IRWrite	:out std_logic;
		MemWrite,PCWrite:out std_logic;
		Branch,RegWrite	:out std_logic;
		ALUOp			:out std_logic_vector(1 downto 0);
		StateNow 		:out std_logic_vector(3 downto 0)
	);
end;
architecture behave of fsm is
	
	type StateType is(
					 S_FECTH,
					 S_DECODE,
					 S_MEMADR,
					 S_MEMREAD,
					 S_MEMWRITEBACK,
					 S_MEMWRITE,
					 S_EXECUTE,
					 S_ALUWRITEBACK,
					 S_BRANCH,
					 S_ADDIEXEC,
					 S_ADDIWRITEBACK,
					 S_JUMP
					);
	
	
	constant OP_RTYPE	:std_logic_vector(5 downto 0):="000000";
	constant OP_LW		:std_logic_vector(5 downto 0):="100011";
	constant OP_SW		:std_logic_vector(5 downto 0):="101011";
	constant OP_BEQ		:std_logic_vector(5 downto 0):="000100";
	constant OP_ADDI	:std_logic_vector(5 downto 0):="001000";
	constant OP_J		:std_logic_vector(5 downto 0):="000010";
	
	signal state,nextState:StateType;
begin
	process(all) is
	begin
		if(reset='1') then
			state<= S_FECTH;
		elsif rising_edge(clk) then
			state<=nextState;
		end if;

--		MemtoReg,RegDst	:out std_logic;
--		IorD,PCSrc		:out std_logic;
--		ALUSrcB			:out std_logic_vector(1 downto 0);
--		AluSrcA,IRWrite	:out std_logic;
--		MemWrite,PCWrite:out std_logic;
--		Branch,RegWrite	:out std_logic;
--		ALUOp			:out std_logic_vector(1 downto 0)
	end process;

		nextState <= S_DECODE when(state=S_FECTH) else
				S_MEMADR when((state=S_DECODE)and((Opcode=OP_LW)or(Opcode=OP_SW))) else
				S_BRANCH when((state=S_DECODE) and(Opcode=OP_BEQ)) else
				S_ADDIEXEC when((state=S_DECODE) and(Opcode=OP_ADDI)) else
				S_JUMP  when((state=S_DECODE) and(Opcode=OP_J)) else
				S_MEMREAD  when((state=S_MEMADR) and(Opcode=OP_LW))else
				S_MEMWRITE when((state=S_MEMADR) and(Opcode=OP_SW)) else
				S_MEMWRITEBACK  when(state=S_MEMREAD) else
				S_ALUWRITEBACK when(state=S_EXECUTE) else
				S_ADDIWRITEBACK when(state=S_ADDIEXEC) else
				S_FECTH when((state=S_MEMWRITEBACK)	
							or(state=S_MEMWRITE)
							or(state=S_ALUWRITEBACK)
							or(state=S_BRANCH)	
							or(state=S_ADDIWRITEBACK)
							or(state=S_JUMP))else
				S_EXECUTE;
		with state select
			IorD 	<= 	'1' when S_MEMREAD|S_MEMWRITE,
						'0' when others;
		with state select
			AluSrcA <= 	'1' when S_EXECUTE|S_BRANCH|S_ADDIEXEC|S_MEMADR,
						'0' when others;
		with state select
			RegDst	<= 	'1' when S_ALUWRITEBACK,
						'0' when others;
		with state select
			MemtoReg<= 	'1' when S_MEMWRITEBACK,
						'0' when others;
		with state select
			ALUSrcB	<= 	"01" when S_FECTH,
						"10" when S_ADDIEXEC|S_MEMADR,
						"11" when S_DECODE,
						"00" when others;
		with state select
			ALUOp	<= 	"01" when S_BRANCH,
						"10" when S_EXECUTE,
						"00" when others;
		with state select
			PCSrc	<= 	"01" when S_BRANCH,
						"10" when S_JUMP,
						"00" when others;						
		with state select
			IRWrite	<= 	'1' when S_FECTH,
						'0' when others;
		with state select
			PCWrite	<= 	'1' when S_FECTH|S_JUMP,
						'0' when others;
		with state select
			Branch	<= 	'1' when S_BRANCH,
						'0' when others;
		with state select
			MemWrite<= 	'1' when S_MEMWRITE,
						'0' when others;
		with state select
			RegWrite<= 	'1' when S_MEMWRITEBACK|S_ALUWRITEBACK|S_ADDIWRITEBACK,
						'0' when others;

				
	-- constant  S_FECTH		:integer<=0;
	-- constant  S_DECODE		:integer<=1;
	-- constant  S_MEMADR		:integer<=2;
	-- constant  S_MEMREAD		:integer<=3;
	-- constant  S_MEMWRITEBACK	:integer<=4;
	-- constant  S_MEMWRITE		:integer<=5;
	-- constant  S_EXECUTE		:integer<=6;
	-- constant  S_ALUWRITEBACK	:integer<=7;
	-- constant  S_BRANCH		:integer<=8;
	-- constant  S_ADDIEXEC		:integer<=9;
	-- constant  S_ADDIWRITEBACK:integer<=10;
	-- constant  S_JUMP			:integer<=11;
		with state select StateNow<=
				x"0" when S_FECTH,
				x"1" when S_DECODE,
				x"2" when S_MEMADR,
				x"3" when S_MEMREAD,
				x"4" when S_MEMWRITEBACK,
				x"5" when S_MEMWRITE,
				x"6" when S_EXECUTE,
				x"7" when S_ALUWRITEBACK,
				x"8" when S_BRANCH,
				x"9" when S_ADDIEXEC,
				x"A" when S_ADDIWRITEBACK,
				x"B" when S_JUMP;
end;