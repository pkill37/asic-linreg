/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern void execute_35(char*, char *);
extern void execute_37(char*, char *);
extern void execute_38(char*, char *);
extern void execute_61(char*, char *);
extern void execute_41(char*, char *);
extern void execute_43(char*, char *);
extern void execute_45(char*, char *);
extern void execute_47(char*, char *);
extern void execute_49(char*, char *);
extern void execute_51(char*, char *);
extern void execute_53(char*, char *);
extern void execute_55(char*, char *);
extern void execute_57(char*, char *);
extern void execute_59(char*, char *);
extern void execute_124(char*, char *);
extern void execute_65(char*, char *);
extern void execute_67(char*, char *);
extern void execute_71(char*, char *);
extern void execute_73(char*, char *);
extern void execute_77(char*, char *);
extern void execute_79(char*, char *);
extern void execute_83(char*, char *);
extern void execute_85(char*, char *);
extern void execute_89(char*, char *);
extern void execute_91(char*, char *);
extern void execute_95(char*, char *);
extern void execute_97(char*, char *);
extern void execute_101(char*, char *);
extern void execute_103(char*, char *);
extern void execute_107(char*, char *);
extern void execute_109(char*, char *);
extern void execute_113(char*, char *);
extern void execute_115(char*, char *);
extern void execute_119(char*, char *);
extern void execute_121(char*, char *);
extern void execute_126(char*, char *);
extern void execute_127(char*, char *);
extern void execute_134(char*, char *);
extern void execute_130(char*, char *);
extern void execute_132(char*, char *);
extern void execute_141(char*, char *);
extern void execute_137(char*, char *);
extern void execute_139(char*, char *);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[44] = {(funcp)execute_35, (funcp)execute_37, (funcp)execute_38, (funcp)execute_61, (funcp)execute_41, (funcp)execute_43, (funcp)execute_45, (funcp)execute_47, (funcp)execute_49, (funcp)execute_51, (funcp)execute_53, (funcp)execute_55, (funcp)execute_57, (funcp)execute_59, (funcp)execute_124, (funcp)execute_65, (funcp)execute_67, (funcp)execute_71, (funcp)execute_73, (funcp)execute_77, (funcp)execute_79, (funcp)execute_83, (funcp)execute_85, (funcp)execute_89, (funcp)execute_91, (funcp)execute_95, (funcp)execute_97, (funcp)execute_101, (funcp)execute_103, (funcp)execute_107, (funcp)execute_109, (funcp)execute_113, (funcp)execute_115, (funcp)execute_119, (funcp)execute_121, (funcp)execute_126, (funcp)execute_127, (funcp)execute_134, (funcp)execute_130, (funcp)execute_132, (funcp)execute_141, (funcp)execute_137, (funcp)execute_139, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 44;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/MiniBatchGradientDescentTest_behav/xsim.reloc",  (void **)funcTab, 44);
	iki_vhdl_file_variable_register(dp + 6824);
	iki_vhdl_file_variable_register(dp + 6880);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/MiniBatchGradientDescentTest_behav/xsim.reloc");
}

void simulate(char *dp)
{
	iki_schedule_processes_at_time_zero(dp, "xsim.dir/MiniBatchGradientDescentTest_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/MiniBatchGradientDescentTest_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/MiniBatchGradientDescentTest_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/MiniBatchGradientDescentTest_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
