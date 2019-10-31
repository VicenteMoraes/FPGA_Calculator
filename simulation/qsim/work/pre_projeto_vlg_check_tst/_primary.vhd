library verilog;
use verilog.vl_types.all;
entity pre_projeto_vlg_check_tst is
    port(
        blah            : in     vl_logic_vector(7 downto 0);
        HEX0            : in     vl_logic_vector(6 downto 0);
        HEX1            : in     vl_logic_vector(6 downto 0);
        HEX2            : in     vl_logic_vector(6 downto 0);
        HEX3            : in     vl_logic_vector(6 downto 0);
        HEX4            : in     vl_logic_vector(6 downto 0);
        HEX5            : in     vl_logic_vector(6 downto 0);
        HEX6            : in     vl_logic_vector(6 downto 0);
        HEX7            : in     vl_logic_vector(6 downto 0);
        teste           : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end pre_projeto_vlg_check_tst;
