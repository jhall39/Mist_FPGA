library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity rom_char_u is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(11 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of rom_char_u is
	type rom is array(0 to  4095) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"00",X"7C",X"C6",X"C6",X"C6",X"C6",X"C6",X"7C",X"00",X"18",X"1C",X"18",X"18",X"18",X"18",X"3C",
		X"00",X"7C",X"E6",X"C6",X"30",X"0C",X"C6",X"7E",X"00",X"7C",X"C6",X"C0",X"70",X"C6",X"C6",X"7C",
		X"00",X"68",X"68",X"6C",X"64",X"FE",X"60",X"F0",X"00",X"7E",X"02",X"7E",X"C2",X"C0",X"C6",X"7C",
		X"00",X"7C",X"C6",X"06",X"7E",X"C6",X"C6",X"7C",X"00",X"FE",X"C2",X"C2",X"60",X"30",X"18",X"18",
		X"00",X"7C",X"C6",X"C6",X"7C",X"C6",X"C6",X"7C",X"00",X"7C",X"C6",X"C6",X"FC",X"C0",X"C6",X"7C",
		X"00",X"70",X"58",X"C8",X"CC",X"FC",X"C6",X"C6",X"00",X"7E",X"CC",X"CC",X"7C",X"CC",X"CC",X"7E",
		X"00",X"78",X"CC",X"06",X"06",X"86",X"CC",X"78",X"00",X"3E",X"6C",X"CC",X"CC",X"CC",X"6C",X"3E",
		X"00",X"FE",X"CC",X"0C",X"3C",X"0C",X"CC",X"FE",X"00",X"FE",X"CC",X"0C",X"3C",X"0C",X"0C",X"1E",
		X"00",X"78",X"CC",X"06",X"06",X"E6",X"CC",X"78",X"00",X"EE",X"6C",X"6C",X"7C",X"6C",X"6C",X"EE",
		X"00",X"3C",X"18",X"18",X"18",X"18",X"18",X"3C",X"00",X"F0",X"60",X"60",X"60",X"60",X"6C",X"38",
		X"00",X"9E",X"CC",X"6C",X"3C",X"6C",X"CC",X"DE",X"00",X"1E",X"0C",X"0C",X"0C",X"0C",X"CC",X"FE",
		X"00",X"C6",X"EE",X"FE",X"D6",X"D6",X"C6",X"C6",X"00",X"C6",X"CE",X"DE",X"F6",X"E6",X"C6",X"C6",
		X"00",X"7C",X"C6",X"C6",X"C6",X"C6",X"C6",X"7C",X"00",X"7E",X"CC",X"CC",X"7C",X"0C",X"0C",X"1E",
		X"00",X"38",X"6C",X"C6",X"C6",X"D6",X"6C",X"D8",X"00",X"7E",X"CC",X"CC",X"7C",X"6C",X"CC",X"DE",
		X"00",X"7C",X"8E",X"1C",X"78",X"F0",X"E2",X"7C",X"00",X"7E",X"5A",X"18",X"18",X"18",X"18",X"3C",
		X"00",X"DE",X"8C",X"8C",X"8C",X"8C",X"8C",X"78",X"00",X"DE",X"8C",X"8C",X"8C",X"58",X"58",X"30",
		X"00",X"B6",X"B6",X"B6",X"B6",X"FE",X"6C",X"28",X"00",X"C6",X"6E",X"3C",X"38",X"78",X"EC",X"C6",
		X"00",X"E6",X"6C",X"78",X"30",X"30",X"18",X"1C",X"00",X"FE",X"E6",X"70",X"38",X"1C",X"CE",X"FE",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"10",X"00",X"00",X"00",
		X"00",X"00",X"10",X"00",X"00",X"10",X"00",X"00",X"00",X"0C",X"12",X"14",X"08",X"14",X"22",X"7C",
		X"30",X"30",X"38",X"38",X"18",X"08",X"00",X"04",X"38",X"44",X"44",X"20",X"10",X"10",X"00",X"10",
		X"00",X"20",X"10",X"08",X"08",X"08",X"10",X"20",X"00",X"08",X"10",X"20",X"20",X"20",X"10",X"08",
		X"00",X"10",X"10",X"10",X"FE",X"10",X"10",X"10",X"00",X"00",X"00",X"00",X"7E",X"00",X"00",X"00",
		X"00",X"00",X"7E",X"00",X"00",X"7E",X"00",X"00",X"00",X"44",X"EE",X"EE",X"FE",X"7C",X"38",X"10",
		X"38",X"44",X"44",X"38",X"10",X"7C",X"10",X"10",X"10",X"38",X"54",X"10",X"38",X"44",X"44",X"38",
		X"18",X"38",X"28",X"48",X"28",X"0C",X"0E",X"06",X"10",X"38",X"7C",X"54",X"FE",X"28",X"44",X"28",
		X"00",X"00",X"A7",X"A9",X"A7",X"A5",X"49",X"00",X"00",X"00",X"02",X"06",X"0A",X"0A",X"06",X"00",
		X"00",X"00",X"07",X"31",X"53",X"51",X"57",X"00",X"00",X"04",X"04",X"06",X"05",X"05",X"06",X"00",
		X"00",X"00",X"00",X"FF",X"FF",X"00",X"00",X"00",X"10",X"38",X"7C",X"FE",X"38",X"38",X"38",X"38",
		X"3C",X"42",X"99",X"85",X"85",X"99",X"42",X"3C",X"00",X"60",X"60",X"30",X"10",X"00",X"00",X"00",
		X"FE",X"F2",X"02",X"02",X"02",X"FE",X"FE",X"00",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"00",X"F8",X"F8",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",
		X"18",X"18",X"F8",X"F8",X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FF",X"00",X"00",X"00",X"00",
		X"00",X"00",X"FF",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FF",X"18",X"18",X"18",X"18",
		X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"FF",X"FF",X"00",X"00",X"00",X"00",
		X"00",X"00",X"1F",X"1F",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",X"18",
		X"18",X"18",X"1F",X"1F",X"00",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"01",X"01",X"01",X"01",X"01",X"01",X"01",X"FF",X"FF",X"01",X"01",X"01",X"01",X"01",X"01",X"FF",
		X"81",X"81",X"81",X"81",X"81",X"81",X"81",X"FF",X"FF",X"81",X"81",X"81",X"81",X"81",X"81",X"FF",
		X"00",X"D8",X"50",X"50",X"50",X"D0",X"00",X"00",X"00",X"F9",X"1D",X"0D",X"1D",X"F9",X"00",X"00",
		X"0C",X"0E",X"0F",X"0F",X"0F",X"0E",X"0C",X"00",X"00",X"00",X"38",X"28",X"38",X"00",X"00",X"00",
		X"10",X"10",X"10",X"FF",X"FF",X"10",X"10",X"10",X"1F",X"98",X"9A",X"FA",X"FA",X"9A",X"98",X"1F",
		X"3F",X"63",X"41",X"00",X"00",X"41",X"63",X"3F",X"F8",X"CC",X"DE",X"DF",X"DF",X"DE",X"DC",X"F8",
		X"F8",X"8C",X"AE",X"BF",X"8F",X"EE",X"8C",X"F8",X"F8",X"8C",X"BE",X"8F",X"BF",X"BE",X"8C",X"F8",
		X"F8",X"EC",X"EE",X"AF",X"AF",X"8E",X"BC",X"F8",X"F8",X"8C",X"EE",X"8F",X"BF",X"BE",X"8C",X"F8",
		X"F8",X"8C",X"EE",X"8F",X"AF",X"AE",X"8C",X"F8",X"F8",X"8C",X"BE",X"BF",X"BF",X"BE",X"BC",X"F8",
		X"F8",X"8C",X"AE",X"8F",X"AF",X"AE",X"8C",X"F8",X"F8",X"8C",X"AE",X"8F",X"BF",X"BE",X"BC",X"F8",
		X"00",X"00",X"80",X"40",X"30",X"18",X"0C",X"06",X"06",X"1B",X"F0",X"00",X"04",X"1E",X"7F",X"EF",
		X"3F",X"10",X"F8",X"B8",X"3C",X"3C",X"5F",X"5E",X"00",X"00",X"00",X"00",X"00",X"01",X"0E",X"C4",
		X"00",X"00",X"00",X"00",X"00",X"04",X"07",X"14",X"00",X"00",X"00",X"00",X"20",X"30",X"A8",X"E6",
		X"00",X"00",X"00",X"00",X"80",X"60",X"10",X"06",X"00",X"00",X"01",X"03",X"05",X"3E",X"2C",X"E0",
		X"00",X"00",X"00",X"00",X"C0",X"E0",X"00",X"00",X"20",X"70",X"8C",X"C3",X"C0",X"C3",X"C2",X"C2",
		X"00",X"00",X"01",X"01",X"07",X"01",X"81",X"61",X"00",X"00",X"00",X"00",X"02",X"03",X"0A",X"8E",
		X"00",X"00",X"00",X"80",X"40",X"30",X"1C",X"C3",X"00",X"00",X"00",X"80",X"01",X"06",X"38",X"23",
		X"18",X"24",X"72",X"F1",X"73",X"72",X"72",X"72",X"00",X"00",X"30",X"2C",X"E3",X"CC",X"C8",X"E4",
		X"03",X"0E",X"3E",X"F8",X"E0",X"80",X"00",X"78",X"02",X"0C",X"30",X"C0",X"03",X"0F",X"1E",X"7C",
		X"5F",X"5E",X"4C",X"48",X"43",X"44",X"58",X"50",X"3E",X"5E",X"4E",X"4C",X"58",X"5A",X"7A",X"76",
		X"9E",X"1E",X"8E",X"8E",X"8E",X"FE",X"0E",X"42",X"E1",X"C9",X"CD",X"CC",X"DE",X"D6",X"96",X"A6",
		X"0C",X"88",X"90",X"91",X"91",X"91",X"91",X"91",X"DF",X"DF",X"DF",X"D3",X"D3",X"D3",X"D3",X"CB",
		X"00",X"01",X"01",X"01",X"01",X"01",X"0D",X"13",X"C2",X"C2",X"C2",X"C2",X"C2",X"C2",X"C2",X"82",
		X"19",X"8D",X"E9",X"E9",X"69",X"6F",X"61",X"68",X"8E",X"4C",X"4C",X"5C",X"5D",X"5D",X"59",X"5A",
		X"E0",X"F0",X"F8",X"7C",X"3C",X"1C",X"1C",X"1C",X"E7",X"F7",X"F8",X"78",X"68",X"68",X"20",X"20",
		X"72",X"72",X"F2",X"72",X"A2",X"42",X"E2",X"F2",X"F2",X"FA",X"7B",X"38",X"1A",X"1B",X"1B",X"1D",
		X"CC",X"06",X"02",X"03",X"F1",X"F9",X"F9",X"3B",X"E1",X"86",X"8C",X"B8",X"E0",X"01",X"07",X"0E",
		X"70",X"70",X"70",X"70",X"70",X"78",X"3C",X"FE",X"76",X"36",X"0E",X"3E",X"6E",X"4E",X"4E",X"EF",
		X"FE",X"6E",X"AE",X"BE",X"9E",X"DE",X"DE",X"FF",X"A0",X"21",X"03",X"3F",X"7D",X"71",X"60",X"F0",
		X"93",X"93",X"93",X"97",X"97",X"9E",X"8E",X"FF",X"EB",X"FD",X"EF",X"73",X"7B",X"23",X"23",X"23",
		X"39",X"7C",X"7E",X"5E",X"0F",X"0F",X"06",X"04",X"C2",X"C2",X"C2",X"C2",X"C2",X"C2",X"E2",X"F1",
		X"05",X"27",X"37",X"F7",X"B3",X"3B",X"1B",X"1F",X"7A",X"72",X"B0",X"F3",X"77",X"67",X"62",X"FF",
		X"18",X"18",X"38",X"30",X"21",X"01",X"06",X"F8",X"60",X"20",X"30",X"98",X"76",X"68",X"FE",X"3F",
		X"F2",X"72",X"72",X"F1",X"60",X"40",X"F3",X"FF",X"34",X"B4",X"F2",X"A1",X"C4",X"E6",X"F7",X"F9",
		X"3A",X"1E",X"1C",X"18",X"38",X"30",X"60",X"C0",X"0C",X"B0",X"A0",X"C0",X"80",X"00",X"00",X"00",
		X"BF",X"9F",X"0F",X"07",X"03",X"01",X"00",X"00",X"0F",X"8F",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"C1",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"23",X"47",X"C0",X"80",X"00",X"00",X"00",X"00",
		X"98",X"60",X"00",X"00",X"03",X"8E",X"F8",X"F8",X"F8",X"7C",X"3E",X"1F",X"0F",X"07",X"07",X"03",
		X"19",X"3C",X"00",X"00",X"00",X"00",X"00",X"00",X"F8",X"FC",X"00",X"00",X"00",X"00",X"00",X"00",
		X"F8",X"E1",X"00",X"00",X"00",X"00",X"00",X"00",X"1F",X"07",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FE",X"38",X"00",X"00",X"00",X"00",X"00",X"00",X"70",X"20",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"20",X"00",X"00",X"00",X"00",X"00",X"E0",X"66",X"24",
		X"00",X"00",X"00",X"80",X"C2",X"E7",X"66",X"24",X"00",X"80",X"98",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"01",X"19",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"01",X"43",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"07",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"04",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"20",
		X"00",X"00",X"00",X"00",X"00",X"00",X"C0",X"44",X"00",X"00",X"00",X"00",X"00",X"E0",X"66",X"24",
		X"00",X"00",X"00",X"00",X"C0",X"E7",X"66",X"24",X"00",X"00",X"00",X"80",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"98",X"81",X"C3",X"E7",X"66",X"24",X"00",X"98",X"99",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"19",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"19",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"01",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"03",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"07",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"06",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"04",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"60",X"24",
		X"00",X"00",X"00",X"00",X"C0",X"E6",X"66",X"24",X"00",X"90",X"9C",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"60",X"24",
		X"00",X"00",X"00",X"00",X"80",X"C3",X"66",X"24",X"00",X"00",X"80",X"80",X"C3",X"E7",X"66",X"24",
		X"00",X"90",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"09",X"99",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"01",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"03",X"C7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"01",X"06",X"24",X"00",X"01",X"01",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"67",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"06",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"60",X"24",
		X"00",X"00",X"80",X"80",X"C0",X"E7",X"66",X"24",X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"20",X"00",X"00",X"80",X"80",X"C0",X"E7",X"66",X"24",
		X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"20",
		X"00",X"00",X"00",X"80",X"C0",X"E7",X"66",X"24",X"00",X"80",X"98",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"01",X"19",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"01",X"03",X"E7",X"66",X"24",
		X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"04",
		X"00",X"00",X"01",X"01",X"03",X"E7",X"66",X"24",X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"04",X"00",X"00",X"00",X"01",X"03",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"01",X"06",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"20",X"00",X"00",X"00",X"80",X"C0",X"E0",X"66",X"24",
		X"30",X"98",X"98",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"20",
		X"00",X"80",X"90",X"80",X"C2",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"80",X"80",X"C0",X"E0",X"66",X"24",X"3C",X"98",X"99",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"20",X"00",X"00",X"00",X"80",X"C0",X"E6",X"66",X"24",
		X"00",X"90",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"09",X"99",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"01",X"03",X"67",X"66",X"24",X"3C",X"19",X"99",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"04",X"00",X"00",X"01",X"01",X"03",X"07",X"66",X"24",
		X"00",X"01",X"09",X"01",X"43",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0C",X"19",X"19",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"04",
		X"00",X"00",X"00",X"01",X"03",X"07",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"04",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",
		X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"C3",X"7E",X"00",X"00",X"FF",X"FF",X"CC",X"CC",X"FF",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"80",X"C0",X"E0",X"64",X"24",
		X"3C",X"98",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"C0",X"E0",X"60",X"20",
		X"38",X"98",X"98",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"80",X"C0",X"C0",X"60",X"20",
		X"3C",X"98",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"80",X"C0",X"E0",X"60",X"20",
		X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"80",X"C0",X"E0",X"60",X"24",
		X"00",X"18",X"19",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"03",X"07",X"06",X"24",
		X"00",X"01",X"01",X"01",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"80",X"80",X"80",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"04",X"24",
		X"00",X"01",X"01",X"01",X"03",X"27",X"66",X"24",X"00",X"01",X"01",X"01",X"03",X"27",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"01",X"01",X"03",X"27",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"01",X"01",X"03",X"27",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"E0",X"0F",X"C0",X"03",X"F8",X"0F",X"E0",X"07",X"00",X"00",X"00",X"00",X"00",X"C0",X"7C",X"03",
		X"07",X"E0",X"1F",X"F8",X"01",X"C0",X"1F",X"F0",X"00",X"00",X"00",X"00",X"00",X"03",X"3E",X"E0",
		X"F0",X"03",X"CC",X"00",X"F8",X"03",X"E0",X"00",X"00",X"00",X"00",X"00",X"00",X"C0",X"7C",X"07",
		X"01",X"F8",X"0F",X"E0",X"03",X"1E",X"01",X"E0",X"00",X"00",X"00",X"00",X"00",X"03",X"3E",X"E0",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"20",X"00",X"88",X"90",X"80",X"C0",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"80",X"80",X"C0",X"E4",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"30",X"90",X"98",X"80",X"C2",X"E6",X"66",X"24",
		X"00",X"00",X"00",X"00",X"80",X"80",X"40",X"20",X"3C",X"90",X"98",X"81",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"80",X"80",X"C0",X"E0",X"60",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"80",X"90",X"80",X"C0",X"E4",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"38",X"98",X"98",X"80",X"C3",X"E7",X"66",X"24",X"00",X"00",X"80",X"80",X"C0",X"E0",X"60",X"20",
		X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"E0",X"60",X"24",
		X"3C",X"99",X"99",X"81",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"07",X"06",X"04",
		X"1C",X"19",X"19",X"41",X"43",X"E7",X"66",X"24",X"00",X"00",X"01",X"01",X"03",X"07",X"06",X"04",
		X"00",X"01",X"09",X"01",X"03",X"17",X"36",X"14",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"3C",X"19",X"19",X"81",X"C3",X"E7",X"66",X"24",X"00",X"01",X"01",X"01",X"03",X"07",X"06",X"04",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0C",X"09",X"19",X"01",X"43",X"67",X"66",X"24",
		X"00",X"00",X"00",X"00",X"01",X"01",X"02",X"04",X"00",X"01",X"01",X"01",X"03",X"27",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"01",X"01",X"03",X"27",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"04",
		X"C0",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"C0",X"40",X"C0",X"00",X"40",X"00",X"80",X"00",X"C0",X"60",X"30",X"E0",X"20",X"60",X"C0",X"60",
		X"C0",X"64",X"1C",X"F0",X"38",X"60",X"C0",X"70",X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"C2",X"7C",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"C0",X"40",X"C0",X"40",X"00",X"80",X"00",X"00",
		X"C0",X"60",X"30",X"E0",X"30",X"60",X"C0",X"60",X"C2",X"66",X"3C",X"E4",X"3C",X"64",X"C0",X"78",
		X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"C2",X"7E",X"C3",X"66",X"3C",X"E0",X"30",X"40",X"80",X"00",
		X"43",X"66",X"3C",X"07",X"0C",X"02",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"03",X"02",X"00",X"01",X"00",X"00",X"00",X"00",X"03",X"06",X"04",X"07",X"04",X"06",X"03",X"02",
		X"03",X"26",X"1C",X"07",X"1C",X"06",X"03",X"0E",X"C3",X"66",X"3C",X"67",X"3C",X"66",X"43",X"3E",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"02",X"00",X"03",X"00",X"00",X"01",X"00",
		X"03",X"06",X"0C",X"07",X"04",X"06",X"03",X"06",X"03",X"26",X"3C",X"07",X"1C",X"06",X"03",X"0E",
		X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"43",X"3E",X"03",X"02",X"00",X"00",X"00",X"00",X"00",X"00",
		X"C0",X"60",X"20",X"C0",X"00",X"00",X"00",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"C2",X"64",X"3C",X"E0",X"38",X"60",X"C0",X"60",X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"C3",X"7E",
		X"C0",X"60",X"30",X"E0",X"20",X"40",X"80",X"00",X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"C0",X"7C",
		X"03",X"06",X"04",X"03",X"00",X"00",X"00",X"00",X"C3",X"66",X"3C",X"67",X"3C",X"26",X"03",X"0E",
		X"C0",X"40",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"40",X"38",X"03",X"02",X"00",X"01",X"00",X"00",X"00",X"00",
		X"43",X"66",X"3C",X"07",X"1C",X"06",X"03",X"06",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"03",X"06",X"00",X"03",X"00",X"00",X"00",X"00",X"C0",X"60",X"00",X"80",X"00",X"00",X"00",X"00",
		X"C0",X"60",X"00",X"00",X"00",X"00",X"00",X"00",X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"C0",X"78",
		X"40",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"C0",X"78",
		X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"C3",X"66",X"3C",X"E6",X"3C",X"60",X"00",X"00",
		X"03",X"06",X"00",X"01",X"00",X"00",X"00",X"00",X"C3",X"66",X"3C",X"E7",X"3C",X"26",X"03",X"1E",
		X"03",X"02",X"00",X"00",X"00",X"00",X"00",X"00",X"C3",X"66",X"3C",X"67",X"3C",X"06",X"03",X"0E",
		X"03",X"02",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"80",X"00",X"00",X"80",X"00",X"80",X"00",X"00",X"C0",X"60",X"00",X"C0",X"00",X"40",X"C0",X"40",
		X"C0",X"60",X"38",X"E0",X"30",X"60",X"C0",X"60",X"C0",X"60",X"30",X"E0",X"20",X"40",X"80",X"00",
		X"C0",X"64",X"3C",X"E4",X"3C",X"64",X"C0",X"78",X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"C2",X"7E",
		X"03",X"06",X"0C",X"07",X"04",X"02",X"01",X"00",X"03",X"26",X"3C",X"27",X"3C",X"04",X"03",X"1E",
		X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"43",X"7E",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"01",X"00",X"00",X"01",X"00",X"01",X"00",X"00",X"03",X"06",X"00",X"03",X"00",X"02",X"03",X"02",
		X"03",X"06",X"1C",X"07",X"0C",X"06",X"03",X"06",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"C0",X"60",X"20",X"C0",X"00",X"00",X"80",X"00",X"C0",X"60",X"30",X"E0",X"20",X"40",X"80",X"00",
		X"C0",X"64",X"3C",X"64",X"3C",X"60",X"C0",X"78",X"C3",X"66",X"3C",X"67",X"3C",X"66",X"C2",X"7E",
		X"03",X"06",X"0C",X"07",X"04",X"02",X"01",X"00",X"03",X"26",X"3C",X"27",X"3C",X"06",X"03",X"1E",
		X"C3",X"66",X"3C",X"E7",X"3C",X"66",X"43",X"7E",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"03",X"06",X"04",X"03",X"00",X"00",X"01",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"E0",X"38",
		X"00",X"80",X"E0",X"38",X"8E",X"E3",X"60",X"24",X"0E",X"83",X"98",X"80",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"80",X"E0",X"38",X"00",X"80",X"E0",X"38",X"8E",X"E3",X"60",X"24",
		X"0E",X"83",X"98",X"80",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"80",X"E0",X"38",
		X"00",X"80",X"E0",X"38",X"8E",X"E3",X"60",X"24",X"0E",X"83",X"98",X"80",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"80",X"E0",X"38",X"00",X"80",X"E0",X"38",X"8E",X"E3",X"60",X"24",
		X"01",X"01",X"01",X"01",X"01",X"01",X"01",X"FF",X"39",X"39",X"39",X"39",X"39",X"39",X"19",X"09",
		X"39",X"39",X"39",X"39",X"39",X"39",X"39",X"39",X"FF",X"01",X"01",X"39",X"39",X"39",X"39",X"39",
		X"04",X"04",X"06",X"02",X"02",X"03",X"01",X"00",X"80",X"C0",X"60",X"30",X"10",X"18",X"08",X"0C",
		X"1C",X"1C",X"1C",X"1C",X"1C",X"1C",X"0C",X"04",X"FF",X"00",X"00",X"00",X"1C",X"1C",X"1C",X"1C",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"01",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"06",X"02",X"80",X"E0",X"38",X"0C",X"06",X"03",X"FF",X"00",X"00",X"00",X"0E",X"0E",X"0E",X"0E",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"E0",X"3C",X"07",X"00",X"00",X"00",X"00",X"00",X"FF",X"00",X"00",X"00",X"C7",X"C7",X"03",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"07",X"3C",X"E0",X"00",X"00",X"00",X"00",X"00",X"FF",X"00",X"00",X"00",X"E3",X"E3",X"C0",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"60",X"40",X"01",X"07",X"1C",X"30",X"60",X"C0",X"FF",X"00",X"00",X"00",X"70",X"70",X"70",X"70",
		X"20",X"20",X"60",X"40",X"40",X"C0",X"80",X"80",X"01",X"03",X"06",X"0C",X"08",X"18",X"10",X"30",
		X"38",X"38",X"38",X"38",X"38",X"38",X"30",X"20",X"FF",X"00",X"00",X"00",X"38",X"38",X"38",X"38",
		X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"FF",X"9C",X"9C",X"9C",X"9C",X"9C",X"9C",X"98",X"90",
		X"9C",X"9C",X"9C",X"9C",X"9C",X"9C",X"9C",X"9C",X"FF",X"80",X"80",X"80",X"9C",X"9C",X"9C",X"9C",
		X"00",X"01",X"07",X"1C",X"71",X"C7",X"06",X"24",X"70",X"C1",X"19",X"01",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"01",X"07",X"1C",X"00",X"01",X"07",X"1C",X"71",X"C7",X"06",X"24",
		X"70",X"C1",X"19",X"01",X"C3",X"E7",X"66",X"24",X"00",X"00",X"00",X"00",X"00",X"00",X"07",X"1C",
		X"00",X"01",X"07",X"1C",X"71",X"C7",X"06",X"24",X"70",X"C1",X"19",X"01",X"C3",X"E7",X"66",X"24",
		X"00",X"00",X"00",X"00",X"00",X"01",X"07",X"1C",X"00",X"01",X"07",X"1C",X"71",X"C7",X"06",X"24",
		X"00",X"00",X"00",X"00",X"00",X"01",X"07",X"1C",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;
