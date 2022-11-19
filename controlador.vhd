library ieee;
use ieee.std_logic_1164.all;
entity controlador is port(
       clock: in std_logic;
       reset: in std_logic; 
		 
       contagem: out std_logic_vector(3 downto 0)
);
end controlador;
architecture bhv of controlador is
     type STATES is (int,setup,sequence,play,check,waitt,result);
     signal EA, PE: STATES;
begin
     P1: process(clock, reset)
begin
          if reset= '0' then
                   EA <= E0;
             elsif clock'event and clock= '0' then
                   EA <= PE;
          end if;
end process;
P2: process(EA)
begin
  

        case EA is
        when init =>
                      if (E1 = '1') then
							 PE <= setup;
        when setup =>
                      R1<='0';
							 E1<='1';
							 E2<='0';
							 E3<='0';
							 E4<='0';
							 E5<='0';
							 E6<='0';
							 if (KEY1 = '1') then
							 PE <= sequence;
								else(KEY1 = '0')
							   PE <= setup;
							 end if
							 
							 
							 
							   
        when sequence =>
							 R1<='0';
							 E1<='0';
							 E2<='1';
							 E3<='1';
							 E4<='0';
							 E5<='0';
							 E6<='0';
		  
							 if (end_sequence = '1') then
							 PE <= play;
							
								else (end_sequence = '0') then
								PE <= sequence;
        when play => 
							 R1<='0';
							 E1<='0';
							 E2<='0';
							 E3<='1';
							 E4<='0';
							 E5<='0';
							 E6<='0';
							 
							 if  (enter_left and enter_right= '1')then 
							 PE <= check;
								else (E3 = '1') then
								PE <= play;
							end if
		  when check => 
							 R1<='0';
							 E1<='0';
							 E2<='0';
							 E3<='0';
							 E4<='1';
							 E5<='0';
							 E6<='0';
							 
							 
							 PE <= waitt;
								
								
	     when waitt =>
                      contagem <= "0001";
                       PE <= E1;
	     when result =>
                     contagem <= "0001";
                       PE <= E1;
     end case;
  end process;
end bhv;