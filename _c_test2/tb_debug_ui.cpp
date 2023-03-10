#include "tb_debug_ui.h"
#include "time.h"

_log_file_struct  log_file[MAX_LOG_FILES];
int     cmdCount=0;
int     cmdCount_script;
int     setdbgoutCount=0;
time_t  time_start;
time_t  time_end;


FILE            *script_file;
FILE            *fw_script_file;
FILE            *setup_script;
FILE            *dbgUI_out;

int  pause=0;

const char  illegal_parameter_string[] = "Illegal parameter. Type \"help\" for help.\n";
const char  script_file_error[] = "Error during script, script file terminated\n";


void init_debug_ui()
{
  for( int i=0; i<MAX_LOG_FILES; i++)
    log_file[i].log_out = NULL;
  
  setup_script = NULL;
  script_file = NULL;
  fw_script_file = NULL;
  dbgUI_out = stdout;
}


inline  void quit_script(FILE **script_file)
{
  if( (*script_file) != NULL )
  {
    fclose((*script_file));
    (*script_file) = NULL;
    fprintf(dbgUI_out, script_file_error);
  }
}



int tb_debug_ui(int &cycles, char* input_string)
{
  char            cmd_line[128];
  int             j;
  int             ret_val;
  bool            from_cmd_line = (input_string==NULL)? true:false;
  //  fprintf(dbgUI_out, "\nFor help on the debugging interface, enter:  help or ?\n");

  while(setup_script!= NULL)
  {
    fgets(cmd_line, 120, setup_script);
    if( cmd_line[0] == ';' || cmd_line[0] == '\n' || cmd_line[0] == '#' || cmd_line[0] == '%' || strncmp(cmd_line,"//",2)==0 || cmd_line[0] == 0)
      j=0;      //決定讀出來每行是否要算
    else
    {
      fprintf(dbgUI_out, "\nSetup: %s",cmd_line);
      ret_val = tb_debug_kernel(cmd_line, cycles, &setup_script);
    }

    if( feof(setup_script) )
    {
      fclose(setup_script);
      setup_script = NULL;
    }

    if( ret_val == TB_DEBUG_STOP || ret_val == TB_DEBUG_RUN )
    {
      fprintf(dbgUI_out, "\n \"quit\" or \"run\" not allowed in setup script");
    };

    for( j=0; j<128; j++)
      cmd_line[j] = 0;
  }

  if( input_string == NULL )
  {
    while(1)
    {
      if( script_file != NULL )
      {
        fgets(cmd_line, 120, script_file);

        if( feof(script_file) )
        {
          fclose(script_file);
          script_file = NULL;
        }

        if( cmd_line[0] == ';' || cmd_line[0] == '\n' || cmd_line[0] == '#' || cmd_line[0] == '%' || strncmp(cmd_line,"//",2)==0) {}
        else
        {
          cmdCount_script++;
          fprintf(dbgUI_out, "\nCommand %d : \t%s",cmdCount_script,cmd_line);
          ret_val = tb_debug_kernel(cmd_line, cycles, &script_file);
        }
      }
      else
      {
        cmdCount++;
        //fprintf(dbgUI_out, "\n此時number = %d,\t此時number_s = %d",cmdCount,cmdCount_script);
        fprintf( stderr, "\ntb_dvr>");
        gets(cmd_line);
        ret_val = tb_debug_kernel(cmd_line, cycles, &script_file);
      }
      if( ret_val == TB_DEBUG_STOP )
        return TB_DEBUG_STOP;

      if( ret_val == TB_DEBUG_RUN )
        return TB_DEBUG_RUN;

      for( j=0; j<128; j++)
        cmd_line[j] = 0;
    }
  }
  else
  {
    while(1)
    {
      if( fw_script_file != NULL )
      {
        fgets(cmd_line, 120, fw_script_file);
        if( feof(fw_script_file) )
        {
          fclose(fw_script_file);
          fw_script_file = NULL;
        }

        if( cmd_line[0] == ';' || cmd_line[0] == '\n' || cmd_line[0] == '#' || cmd_line[0] == '%' || strncmp(cmd_line,"//",2)==0)
          {}
        else
          ret_val = tb_debug_kernel(cmd_line, cycles, &fw_script_file);
      }
      else
      {
        for( j=0; j<128; j++)
          cmd_line[j] = input_string[j];
        ret_val = tb_debug_kernel(cmd_line, cycles, &fw_script_file);
      }

      if( !fw_script_file )
        return TB_DEBUG_RUN;

      for( j=0; j<128; j++)
        cmd_line[j] = 0;
    }
  }
}

int tb_debug_kernel(char* cmd_line, int &cycles, FILE** script_file)
{
  int           regCount;
  IRegBasePtr   *p_aRegTable;
  FILE          *msg_out = dbgUI_out;
  cycles = 0;


  //**************simulation control***********************
  char            cmd_name[40];
  char            cmd_arg[20][40];
  unsigned int    cmd_str_ptr=0;
  unsigned int    arg_num,j,k;
  //********************parsing ***********************
  // clear buffers
  for( j=0; j<40; j++)
    cmd_name[j] = 0;
  for( j=0; j<20; j++)
    for( k=0; k<40; k++)
      cmd_arg[j][k] = 0;
  cmd_str_ptr = 0;
  while((cmd_line[cmd_str_ptr]==' ' || cmd_line[cmd_str_ptr]=='\t') && cmd_str_ptr<120)
    cmd_str_ptr ++;			//當讀到空白或tab時，找到csp的位置
  j = 0;
  while((cmd_line[cmd_str_ptr]!=' ' && cmd_line[cmd_str_ptr]!='\t') && cmd_line[cmd_str_ptr]!='\0' && cmd_line[cmd_str_ptr]!='\n' && cmd_str_ptr<120)
    cmd_name[j++] = cmd_line[cmd_str_ptr++];    //get first command name //把第一個字串讀進cmd_name
  cmd_name[j]='\0';
  if( cmd_str_ptr >= 120 )
    fprintf(dbgUI_out, "Invalid input\n");
  // similarly, then get the arguments, too
  arg_num=0;
  while(1)
  {
    j=0;
    while((cmd_line[cmd_str_ptr]==' ' || cmd_line[cmd_str_ptr]=='\t') && cmd_str_ptr<120)
      cmd_str_ptr ++;
    if( cmd_line[cmd_str_ptr] >= 120 || cmd_line[cmd_str_ptr]=='\0'|| cmd_line[cmd_str_ptr]=='\n')
      break;
    while(cmd_line[cmd_str_ptr]!='\0' && cmd_line[cmd_str_ptr]!=' '&& cmd_line[cmd_str_ptr]!='\t' && cmd_line[cmd_str_ptr]!='\n' && cmd_str_ptr<120)
      cmd_arg[arg_num][j++] = cmd_line[cmd_str_ptr++];
    cmd_arg[arg_num][j]='\0';
    if( j > 1 || j==1 && cmd_arg[arg_num][j]!=' ') // && cmd_arg[arg_num][j]!='\0')
      arg_num++;
  }
  char cmd_arg_name[20]="";
  char cmd_arg_reg[20]="";
  int  cmd_arg_length=-1;
  int  cmd_arg_index=-1;
  char cmd_arg_code[20]="";
  char cmd_arg_p[20]="";
  int  cmd_arg_pc=-1;
  int  cmd_arg_addr=-1;
  int  cmd_arg_addr_m=-1;
  bool memory_mapping_flag=0;
  int  cmd_arg_cycle=-1;
  char cmd_arg_group[20]="";
  char cmd_arg_file_b[20]="";
  char cmd_arg_file_t[20]="";
  int  cmd_arg_page=-1;

  bool cmd_arg_help_flag=0;
  bool cmd_arg_bigend_flag=0;
  bool cmd_arg_dec_flag=0;
  bool cmd_arg_hex_flag=0;
  int  cmd_arg_dec=-1;
  int  cmd_arg_hex=-1;
  bool cmd_arg_reg_flag=0;
  bool cmd_arg_name_flag=0;

  int  cmd_arg_width=-1;
  int  cmd_arg_height=-1;
  bool cmd_arg_cmt_flag=0;
  char cmd_arg_cmt[100]="";


  int  arg_num_i=0;
  while(arg_num_i < arg_num)
  {
    //fprintf(dbgUI_out, "此時arg_num_i=%d\n",arg_num_i);
    if( strcmp(cmd_arg[arg_num_i], "-l") == 0 )
      cmd_arg_length=str2num(cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-i") == 0 )
      cmd_arg_index=str2num(cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-code") == 0 )
      strcpy(cmd_arg_code , cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], ">>") == 0 )
    {
      arg_num = arg_num_i;  // ignore the rest of the command line comments
      fprintf(dbgUI_out, "Appending output to %s\n", cmd_arg[arg_num_i + 1]);
      msg_out = fopen(cmd_arg[(arg_num_i++) + 1], "a");
    }

    else if( strcmp(cmd_arg[arg_num_i], ">") == 0 )
    {
      arg_num = arg_num_i;  // ignore the rest of the command line comments
      fprintf(dbgUI_out, "Redirecting output to %s\n", cmd_arg[arg_num_i + 1]);
      msg_out = fopen(cmd_arg[(arg_num_i++) + 1], "w");
    }

    else if( strcmp(cmd_arg[arg_num_i], "-p") == 0 )
      strcpy(cmd_arg_p , cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-pc") == 0 )
      cmd_arg_pc=str2num(cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-addr") == 0 ||  strcmp(cmd_arg[arg_num_i], "-a") == 0 )
      cmd_arg_addr=str2num(cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-m") == 0 )
    {
      cmd_arg_addr_m=str2num(cmd_arg[(arg_num_i++) +1]);
      memory_mapping_flag=1;
    }
    else if( strcmp(cmd_arg[arg_num_i], "-c") == 0 )
      cmd_arg_cycle=str2num(cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-g") == 0 )
      strcpy(cmd_arg_group , cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-f") == 0 )
      strcpy(cmd_arg_file_b , cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-tf") == 0 )
      strcpy(cmd_arg_file_t , cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-page") == 0 )
      cmd_arg_page=str2num(cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-w") == 0 || strcmp(cmd_arg[arg_num_i], "-width") == 0)
      cmd_arg_width=str2num(cmd_arg[(arg_num_i++) +1]);

    else if( strcmp(cmd_arg[arg_num_i], "-?") == 0 )
      cmd_arg_help_flag=1;

    else if( strcmp(cmd_arg[arg_num_i], "-b") == 0 )
      cmd_arg_bigend_flag=1;

    else if( strcmp(cmd_arg[arg_num_i], "-d") == 0 )
    {
      cmd_arg_dec_flag=1;
      if( arg_num_i < (arg_num-1) )
      {
        if(strncmp(cmd_arg[arg_num_i +1],"-",1)!=0 && strncmp(cmd_arg[arg_num_i +1],">",1)!=0)
        {
          cmd_arg_dec=str2num(cmd_arg[arg_num_i +1]);
          arg_num_i += 1;
        }
      }
    }
    else if( strcmp(cmd_arg[arg_num_i], "-h") == 0 )
    {
      cmd_arg_hex_flag=1;
      if( arg_num_i < (arg_num-1) )
      {
        if(strncmp(cmd_arg[arg_num_i +1],"-",1)!=0 && strncmp(cmd_arg[arg_num_i +1],">",1)!=0)
        {
          cmd_arg_hex=hex2dec(cmd_arg[arg_num_i +1]);
          arg_num_i += 1;
        }
      }
    }
    else if( strcmp(cmd_arg[arg_num_i], "-r") == 0 )
    {
      cmd_arg_reg_flag=1;
      if( arg_num_i < (arg_num-1) )
      {
        if(strncmp(cmd_arg[arg_num_i +1],"-",1)!=0)
        {
          strcpy(cmd_arg_reg , cmd_arg[arg_num_i +1]);
          arg_num_i += 1;
        }
      }
    }
    else if( strcmp(cmd_arg[arg_num_i], "-n") == 0 || strcmp(cmd_arg[arg_num_i], "-name") == 0 )
    {
      cmd_arg_name_flag=1;
      if( arg_num_i < (arg_num-1) )
      {
        if(strncmp(cmd_arg[arg_num_i +1],"-",1)!=0)
        {
          strcpy(cmd_arg_name , cmd_arg[arg_num_i +1]);
          arg_num_i += 1;
        }
      }
    }
    else if( strcmp(cmd_arg[arg_num_i], "-size") == 0 )
    {
      cmd_arg_width =str2num(cmd_arg[arg_num_i +1]);
      cmd_arg_height=str2num(cmd_arg[arg_num_i +2]);
      arg_num_i += 2;
    }
    else if( strcmp(cmd_arg[arg_num_i], "-comment") == 0 )
    {
      cmd_arg_cmt_flag=1;
      int length=0;
      while( arg_num_i < (arg_num-1) )
      {
        if(strncmp(cmd_arg[arg_num_i +1],"-",1)!=0)
        {
          length++;
        }
        else
          break;
        arg_num_i++;
      }
      strcpy(cmd_arg_cmt,"//");
      for (int k=arg_num_i-length+1;k<arg_num_i+1;k++)
      {
        strcat(cmd_arg_cmt," ");
        strcat(cmd_arg_cmt,cmd_arg[k]);
      }
      //fprintf(dbgUI_out, "cmd_arg_cmt=%s\n",cmd_arg_cmt);
    }
    arg_num_i += 1;
  }


  // 開始各項功能 ///////////////////////////////////////////////////////

  // run ////////////////////////////////////////////////////////////////
  if( strcmp(cmd_name, "run") == 0 )
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  run [-c cycles]\n"
              "Description: \n"
              "  Runs the simulator giving the cycles or free run until\n"
              "  break point occurs.\n"
              "Options: \n"
              "  -c:  cycles to be executed.\n"
              "Reference command:\n"
              "  run -c 100 \n"
              "    Runs the simulator for 100 cycles \n"
              "  run\n"
              "    Free run \n");

    }
    else
    {
      if( arg_num == 0 )  // this is the case of free run
      {
        cycles = -1;
        return TB_DEBUG_RUN;
      }
      else if( cmd_arg_cycle>0)
      {
        cycles = cmd_arg_cycle;
        return TB_DEBUG_RUN;
      }
      else
      {
        fprintf(dbgUI_out, illegal_parameter_string);
        quit_script(script_file);
      }
    }
  }

  // version ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "ver") == 0)
  {
    //fprintf(dbgUI_out, "\nReaktek DVR 2004  [版本 0.9.4] [ Aug 31, 2004 星期二 ]\n");
    fprintf(dbgUI_out, "++------------------------------------------------------------------------++\n"
           "||                       DVR Testbench System (TM)                        ||\n"
           "||            Version: 0.9.4 () -- Tue Aug 31 12:00:00 2004               ||\n"
           "||        Copyright (c) 1987-2004 by Realtek Semiconductor Corp.          ||\n"
           "||                        All Rights Reserved                             ||\n"
           "||                                                                        ||\n"
           "||        For support, send email to dvr-support@realtek.com.tw           ||\n"
           "||                                                                        ||\n"
           "||     This program is proprietary and confidential information of        ||\n"
           "||   Realtek Semiconductor Corp. and may be used and disclosed only as    ||\n"
           "|| authorized in a license agreement controlling such use and disclosure. ||\n"
           "++------------------------------------------------------------------------++\n");
  }

  // time ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "time") == 0)
  {
    cout << "Current time is: " << sc_time_stamp()<< '\n';
  }

  // list ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "list") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  list [-n] [-r] \n"
              "Description: \n"
              "  List all modules or registers contained in the \n"
              "  current simulater.\n"
              "Options: \n"
              "  -n:   List all modules \n"
              "  -r:   List all registers \n"
              "Reference command: \n"
              "  list -n \n"
              "    List all modules\n");

    }
    else
    {
      int list_fail=0;
      if(cmd_arg_name_flag) //list all module names => list -n
      {
        int i=0;
        fprintf(dbgUI_out, "Module information:\n");
                          //012345678901234567890123456789012345678901234567890123456789
        fprintf(dbgUI_out, " Name               Spec Version        Register No \n");
        while (i<CDebugImp::m_deviceCount)
        {
          fprintf(dbgUI_out, " %-19s %-19s %d\n",CDebugImp::m_deviceTable[i]->getName(), CDebugImp::m_deviceTable[i]->getVerInfo(), CDebugImp::m_deviceTable[i]->getRegCount() );
          i++;
        }
      }
      else if(cmd_arg_reg_flag) //list all register names => list -r
      {
        int i=0;
//        fprintf(dbgUI_out, "All module names:\n");
//        fprintf(dbgUI_out, "regCount\tregisterName\n");
        while (i<CDebugImp::m_deviceCount)
        {
          p_aRegTable = CDebugImp::m_deviceTable[i]->getRegTable(regCount);
          if( regCount > 0 )
          {
            fprintf(msg_out, "\nModule name = \"%s\"\n ", CDebugImp::m_deviceTable[i]->getName());

            for(int reg_i=0; reg_i<regCount; reg_i++)
            {
              if( reg_i%3 == 2 )
                fprintf(msg_out, "[%3d] %-22s\n ",reg_i+1,p_aRegTable[reg_i]->m_registerName);
              else
                fprintf(msg_out, "[%3d] %-22s",reg_i+1,p_aRegTable[reg_i]->m_registerName);
            }
            if( regCount%3 != 0 )
              fprintf(msg_out, "\n");
          }
          i++;
        }
/*        while (i<IRegBase::m_regCount)
        {
          fprintf(dbgUI_out, "%d\t\t%s\n",i,IRegBase::m_regTable[i]->m_registerName);
          i++;
        }*/
      }
      else
      {
        list_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag )
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if(list_fail==1)
        quit_script(script_file);

      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // help ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "help") == 0 || strcmp(cmd_name, "?") == 0 )
  {
    //    fprintf(dbgUI_out, "Reference commands:\n");
    //    fprintf(dbgUI_out, "? or help        For this help menu\n");
    fprintf(dbgUI_out, "General commands:\n"
           "  list -?         For list function help.\n"
           "  run -?          For run function help.\n"
           "  script -?       For script function help.\n"
           "  setdbgout -?    For setdbgout function help.\n"
           "  quit            Leave the debugging interface.\n"
           "Register commands:\n"
           "  read -?         For read function help.\n"
           "  write -?        For write function help\n"
           "Memory commands:\n"
           "  load -?         For load function help.\n"
           "  loadimg -?      For loadimg function help.\n"
           "  store -?        For store function help.\n"
           "  storeimg -?     For storeimg function help.\n"
           "  setimgpar -?    For setimgpar function help.\n"
           "CPU commands:\n"
           "  loadprog -?     For loadprog function help\n"
           "  setbreak -?     For setbreak function help.\n"
           "  clrbreak -?     For clrbreak function help.\n"
           "  showbreak -?    For showbreak function help.\n"
           "  setreg -?       For setreg function help.\n"
           "  showcpureg -?   For showcpureg function help.\n"
           "CEI engine commands:\n"
           "  setceibreak -?  For setceibreak function help.\n"
           "  clrceibreak -?  For clrceibreak function help.\n"
           "  showceibreak -? For showceibreak function help.\n");
  }

  // read ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "read") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out, "Usage: \n"
             "  read [-p preceding_initials] [-r register_name.field_name] [-d] [-h] \n"
             "Description: \n"
             "  Read register data. \n"
             "Options: \n"
             "  -p: Preceding initials \n"
             "  -r: Register or register field \n"
             "  -d: Decimal output \n"
             "  -h: Hex output \n"
             "Reference command:\n"
             "  read -p ME_ -h \n"
             "    Print all register with the preceding name of \"ME_\" in hex mode. \n"
             "  read -r ME_CTRL -d \n"
             "    Print ME_CTRL register in decimal mode. Field values will be printed.\n"
             "  read -r ME_CTRL.go -d \n"
             "    Print ME_CTRL register's \"go\" field in decimal mode. \n");
    }
    else
    {
      int read_fail=0;
      int k=0;
      int isfield=0;      //先確認有無要讀field，即cmd_arg_reg是否有'.'
      while(k<strlen(cmd_arg_reg))
      {
        if (cmd_arg_reg[k]=='.')
          isfield++;
        k++;
      }
      if( strlen(cmd_arg_p) && arg_num==3)   //ex: read -d -p ME_
      {
        int i=0; int match=0;
        //                  0123456789012345678901234567890123456789
        fprintf(msg_out, "Register name              Value\n ");
        while (i<CDebugImp::m_deviceCount)
        {
          p_aRegTable = CDebugImp::m_deviceTable[i]->getRegTable(regCount);
          for( int reg_i=0; reg_i<regCount; reg_i ++)
          {
            if (strncmp(p_aRegTable[reg_i]->m_registerName,cmd_arg_p,strlen(cmd_arg_p))==0)
            {
              ULONG   value = p_aRegTable[reg_i]->read();
              if(cmd_arg_dec_flag)
                fprintf(msg_out, "[%3d] %-20s%-15d",match+1,p_aRegTable[reg_i]->m_registerName,value);
              else if(cmd_arg_hex_flag)
                fprintf(msg_out, "[%3d] %-20s%-15x",match+1,p_aRegTable[reg_i]->m_registerName,value);
              match++;
              if( match %2 == 0 )
                fprintf(msg_out, "\n ");
            }
          }
          i++;
        }
/*        while (i<IRegBase::m_regCount)
        {
          if (strncmp(IRegBase::m_regTable[i]->m_registerName,cmd_arg_p,strlen(cmd_arg_p))==0)
          {
            if(cmd_arg_dec_flag)
              fprintf(dbgUI_out, "%s\t%d\n",IRegBase::m_regTable[i]->m_registerName,IRegBase::m_regTable[i]->read());
            else if(cmd_arg_hex_flag)
              fprintf(dbgUI_out, "%s\t%x\n",IRegBase::m_regTable[i]->m_registerName,IRegBase::m_regTable[i]->read());
            match++;
          }
          i++;
        }*/
        if (match==0) //看看是否有找到名字相符的
        {
          fprintf(dbgUI_out, "No matched register name found\n");
          read_fail=1;
        }
      }
      else if( !strlen(cmd_arg_p) && strlen(cmd_arg_reg) && arg_num==3)    //ex: read -d  -r ME_CTRL
      {
        if(isfield==0)      //無field狀況，輸入只有register
        {
          int i=0; int match=0;
          fprintf(msg_out, "Field name\tValue\n");
          
          while (i<CDebugImp::m_deviceCount)
          {
            p_aRegTable = CDebugImp::m_deviceTable[i]->getRegTable(regCount);
            for( int reg_i=0; reg_i< regCount; reg_i++)
            {
              if (strcmp(p_aRegTable[reg_i]->m_registerName,cmd_arg_reg)==0)
              {
                if(cmd_arg_dec_flag)
                  for(int i=0;i<p_aRegTable[reg_i]->getFieldCnt(); i++)
                    fprintf(msg_out, "%12s = %8d\n", p_aRegTable[reg_i]->getFieldName(i), (ULONG)p_aRegTable[reg_i]->getFieldData(i));
                else if(cmd_arg_hex_flag)
                  for(int i=0;i<p_aRegTable[reg_i]->getFieldCnt(); i++)
                    fprintf(msg_out, "%12s = 0x%08x\n", p_aRegTable[reg_i]->getFieldName(i), (ULONG)p_aRegTable[reg_i]->getFieldData(i));
//                  p_aRegTable[reg_i]->print(true);
                else
                {
                  fprintf(dbgUI_out, illegal_parameter_string);
                  read_fail=1;
                }
                match++;
              }
            }
            i++;
          }
          if (match==0)   //看看是否有找到名字相符的
          {
            fprintf(dbgUI_out, "No matched register name found\n");
            read_fail=1;
          }
        }
        if(isfield!=0)  //有field狀況，輸入有field    ex: read -d -r ME_CTRL.tw
        {
          char cmd_arg_register[20];
          char cmd_arg_field[20];
          int i=0;
          int j=0;
          int match=0;

          while(cmd_arg_reg[i]!='.')
            cmd_arg_register[i]=cmd_arg_reg[i++];

          cmd_arg_register[i++]='\0';

          while(cmd_arg_reg[i]!='\0')
            cmd_arg_field[j++]=cmd_arg_reg[i++];

          cmd_arg_field[j]='\0';

          i=0;
          fprintf(msg_out, "Field name\tValue\n");
          
          while (i<CDebugImp::m_deviceCount)
          {
            p_aRegTable = CDebugImp::m_deviceTable[i]->getRegTable(regCount);
            for( int reg_i=0; reg_i < regCount; reg_i++)
            {
              if (strcmp(p_aRegTable[reg_i]->m_registerName,cmd_arg_register)==0)
              {
                ULONG data;
                if( p_aRegTable[reg_i]->readField(cmd_arg_field, &data) )
                {
                  if(cmd_arg_dec_flag)
                    for(int i=0;i<p_aRegTable[reg_i]->getFieldCnt(); i++)
                      fprintf(msg_out, "%12s = %8d\n", p_aRegTable[reg_i]->getFieldName(i), (ULONG)p_aRegTable[reg_i]->getFieldData(i));
                  else if(cmd_arg_hex_flag)
                    for(int i=0;i<p_aRegTable[reg_i]->getFieldCnt(); i++)
                      fprintf(msg_out, "%12s = 0x%08x\n", p_aRegTable[reg_i]->getFieldName(i), (ULONG)p_aRegTable[reg_i]->getFieldData(i));

/*                  if(cmd_arg_dec_flag)
                    fprintf(dbgUI_out, "%s\t%d\n",cmd_arg_field,data);
                  else if(cmd_arg_hex_flag)
                    fprintf(dbgUI_out, "%s\t%x\n",cmd_arg_field,data);*/
                  else
                  {
                    fprintf(dbgUI_out, illegal_parameter_string);
                    read_fail=1;
                  }
                  match++;
                }
              }
            }
            i++;
          }
          if (match==0)   //看看是否有找到名字相符的
          {
            fprintf(dbgUI_out, "No matched register or field name found, and no data is read.\n");
            read_fail=1;
          }
        }
      }
      else
      {
        read_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }

      if(read_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // readme ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "readme") == 0)
  {
    cout << "Readme!!\n";
  }

  // profile start /////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "profile_start") == 0)
  {
    time(&time_start);
  }

  // profile end ///////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "profile_end") == 0)
  {
    time(&time_end);
    fprintf(dbgUI_out, "Total seconds passed: %u", (time_end - time_start));
  }

  //write ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "write") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out, "Usage: \n"
             "  write [-r register_name.field_name] [-d decimal value] [-h hex value] \n"
             "Description: \n"
             "  Write register data. \n"
             "Options: \n"
             "  -r: Register or register field \n"
             "  -d: Specify decimal value input \n"
             "  -h: Specify hex value input \n"
             "Reference command:\n"
             "  write -r ME_CTRL -h 0x00001000\n"
             "    Write 0x00001000 to ME_CTRL. \n"
             "  write -r ME_CTRL.go -d 1\n"
             "    Write 1 to ME_CTRL.go.\n");
    }
    else
    {
      int write_fail=0;
      int write_value=0;
      int k=0;
      int isfield=0;                  //確認有無要寫到field，即cmd_arg_reg是否有'.'
      while(k<strlen(cmd_arg_reg))
      {
        if (cmd_arg_reg[k]=='.')
          isfield++;
        k++;
      }

      if(arg_num==4 && isfield==0)    //無field狀況
      {
        // TBD: write register
        //1.比對是否有此register，2.若有，把-d -h後的改成數值，3.寫資料
        //4.若無此register，則顯示無此register。
        int i=0;int match=0;
        write_value=(cmd_arg_dec_flag)?cmd_arg_dec:cmd_arg_hex;
        
        while (i<CDebugImp::m_deviceCount)
        {
          p_aRegTable = CDebugImp::m_deviceTable[i]->getRegTable(regCount);
          for( int reg_i=0; reg_i < regCount; reg_i++)
          {
            if (strcmp(p_aRegTable[reg_i]->m_registerName,cmd_arg_reg)==0)
            {
              p_aRegTable[reg_i]->write(write_value);     //寫資料
              match++;
            }
          }
          i++;
        }
        if (match==0) //看看是否有找到名字相符的
        {
          fprintf(dbgUI_out, "No matched register name found, and no data is written.\n");
          write_fail=1;
        }
      }
      else if(arg_num==4 && isfield!=0)  //有field狀況
      {
        //1.先把cmd_arg[0]切成cmd_arg_register及cmd_arg_field
        //2.比對是否有此register，3.若有，比對是否有此field
        //4.把arg[1]改成數值，5.寫資料，
        //6.若無此register或field，則顯示無此register或field。
        char cmd_arg_register[40];
        char cmd_arg_field[40];
        //cout << "cmd_arg[0] is " << cmd_arg[0] <<'\n';
        int i=0;
        while(cmd_arg_reg[i]!='.')
        {
          cmd_arg_register[i]=cmd_arg_reg[i];
          i++;
        }
        cmd_arg_register[i]='\0';
        //cout << "Register :\t" << cmd_arg_register << '\n';
        int j=0;
        i++;
        while(cmd_arg_reg[i]!='\0')
        {
          cmd_arg_field[j]=cmd_arg_reg[i];
          i++;j++;
        }
        cmd_arg_field[j]='\0';
        //cout << "Field :\t\t" << cmd_arg_field << '\n';
        i=0;int match=0;
        write_value=(cmd_arg_dec_flag)?cmd_arg_dec:cmd_arg_hex;
        while (i<CDebugImp::m_deviceCount)
        {
          p_aRegTable = CDebugImp::m_deviceTable[i]->getRegTable(regCount);
          for( int reg_i=0; reg_i<regCount; reg_i++)
          {
            if (strcmp(p_aRegTable[reg_i]->m_registerName,cmd_arg_register)==0)
            {
              ULONG data;
              p_aRegTable[reg_i]->writeField(cmd_arg_field,write_value);  //寫資料
              p_aRegTable[reg_i]->readField(cmd_arg_field, &data);   //再把資料讀出來
              if( data != write_value )       //比對寫讀的資料是不是一樣
              {
                fprintf(dbgUI_out, "Write data fail!\n");
                fprintf(dbgUI_out, "Invalid field name or write-value.\n");
                //                fprintf(dbgUI_out, "Please write again, or enter: write -? for writing help.\n");
                write_fail=1;
              }
              match++;
            }
          }
          i++;
        }
        if (match==0) //看看是否有找到名字相符的
        {
          fprintf(dbgUI_out, "No matched register name found, and no data is written.\n");
          write_fail=1;
        }
      }
      else
      {
        write_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }

      if(write_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // load ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "load") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  load [-f binary_file | -tf text_file] [-n module_name] [-a address]\n"
              "Description: \n"
              "  Load data file to memory. \n"
              "Options: \n"
              "  -f:   Binary file \n"
              "  -tf:  Text file \n"
              "  -n:   Target module \n"
              "  -a:   Target address. If \"-n\" is not present, the address \n"
              "        will be treated as physical address of memory space \n"
              "Reference command:\n"
              "  load -f tb_data -n DCU_Mem -a 1280000\n"
              "    Load binary data from \"tb_data\" to DCU_Mem address 1280000 \n"
              "  load -tf loadmem2.txt  -n DCU_Mem\n"
              "    Load text data from \"tb_data\" to DCU_Mem address 1280000 \n"
              "  load -f tb_data -a 0x1280000\n"
              "    Load binary data from \"tb_data\" to physical address 1280000 \n");
    }
    else
    {
      int load_fail=0;
      if(arg_num==6 && strlen(cmd_arg_file_b) && strlen(cmd_arg_name) && cmd_arg_addr!=-1 )
        //ex: load -f tb_inst -n DCU_Mem -a 1280000
      {
        FILE  *image_file;
        BYTE  *data;      //buffer大小
        int   length=0;   //要抓的長度
        int   i=0;
        image_file = fopen(cmd_arg_file_b, "rb");
        if(!image_file)
        {
          fprintf(dbgUI_out, "%s : No such file or directory.\n",cmd_arg_file_b);
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          load_fail=1;
        }
        else
        {
          //              fprintf(dbgUI_out, "File %s is opened.\n",cmd_arg_file_b);
        }
        while(!load_fail)
        {
          fgetc(image_file);
          if( feof(image_file) )
            break;
          length ++;
        }
        if (!load_fail)
        {
          data = new BYTE[length];
          fseek(image_file, 0, SEEK_SET);
          while(i<length)
            data[i++] = fgetc(image_file);
          int ret;
          ret=CDebugImp::memWrite(cmd_arg_name, data, cmd_arg_addr, length);
          delete [] data;
          fclose(image_file);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when writing data.\n");
            load_fail=1;
          }
        }
      }
      else if(arg_num==4 && strlen(cmd_arg_file_t) && ( cmd_arg_addr!=-1  || strlen(cmd_arg_name)))
        //ex: load -tf loadmem2.txt  -n DCU_Mem
        //ex: load -tf loadmem2.txt  -a 0x00002379
      {
        //FILE *mem_file;
        const ULONG BufferSize=1500;      //檔案裡總共多少個byte，需改大
        char mem_read[BufferSize][20];    //每個字串最大容量
        bool R_Bus_Mapping_Flag = 0;

        ifstream fin(cmd_arg_file_t);
        if(!fin)
        {
          fprintf(dbgUI_out, "%s : No such file or directory.\n",cmd_arg_file_t);
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          load_fail=1;
        }
        else
        {
          //              fprintf(dbgUI_out, "File %s is opened.\n",cmd_arg_file_t);
          int dataCount=0;      //有效的data總數
          char AddressJump[20];
          int Ai=0;                 //Address個數指標
          int writemem;
          int nonbin=0;
          int nonhex=0;
          int i;
          int dataCountLast=0;
          int Bl;
          int Bl_sum=0;
          int Addr_next=0;
          int binorhex=0;   //預設資料都是binary的
          int BitNum=8;
          int loadAddr=0;
          char addr2module[20];
          int addr_offset;

          //若是-a => 先由位址算出所屬的module
          //ex: load -tf loadmem2.txt -a 0x18009004
          char reg_name[40];
          if (cmd_arg_addr!=-1)
          {
            //fprintf(dbgUI_out, "Addr=%d in dec\n",cmd_arg_addr);
            //fprintf(dbgUI_out, "result=%x in hex\n",cmd_arg_addr);
            if     (cmd_arg_addr >= 0x00000000 && cmd_arg_addr <= 0x0fffffff)
            {
              addr_offset=cmd_arg_addr;
              strcpy(addr2module,DCU_NAME);
              loadAddr=1;
              //fprintf(dbgUI_out, "In Region 1\t offset is %x\n",addr_offset);
            }
            else if(cmd_arg_addr >= 0x10000000 && cmd_arg_addr <= 0x10001fff)
            {
              addr_offset=cmd_arg_addr-0x10000000;
              strcpy(addr2module,VCPU_NAME);
              loadAddr=1;
              //fprintf(dbgUI_out, "In Region 2\t offset is %x\n",addr_offset);
            }
            else if(cmd_arg_addr >= 0x10002000 && cmd_arg_addr <= 0x10007fff)
            {
              addr_offset=cmd_arg_addr-0x10002000;
              strcpy(addr2module,ACPU_NAME);
              loadAddr=1;
              //fprintf(dbgUI_out, "In Region 3\t offset is %x\n",addr_offset);
            }
            else if(cmd_arg_addr >= 0x18000000 && cmd_arg_addr <= 0x1803ffff)
            {
              //此區域需尋找register
              int findReg=0;
              int index_n;

              findReg=addr2reg(cmd_arg_addr,&p_aRegTable,reg_name);
              if (findReg==-1)
              {
                fprintf(dbgUI_out, "Can't find register at address %x.",cmd_arg_addr);
              }
              else
              {
                addr_offset=cmd_arg_addr-0x18000000;
                //fprintf(dbgUI_out, "Find register %s\n",reg_name);
                strcpy(addr2module,"RBUS_NAME");  //應無用！
                loadAddr=1;
                R_Bus_Mapping_Flag=1;
                //fprintf(dbgUI_out, "In Region 4\t offset is %x\n",addr_offset);
              }
            }
            else if(cmd_arg_addr >= 0x1e000000 && cmd_arg_addr <= 0x1fcfffff)
            {
              addr_offset=cmd_arg_addr-0x1e000000;
              strcpy(addr2module,"FLASH_NAME");
              loadAddr=1;
              //fprintf(dbgUI_out, "In Region 5\t offset is %x\n",addr_offset);
            }
            else
            {
              strcpy(addr2module,"No module mapped!!\t");
              loadAddr=0;
              load_fail=1;
              fprintf(dbgUI_out, "%x : No such address.\n",cmd_arg_addr);
            }
            //fprintf(dbgUI_out, "此時addr=%x,\taddr_offset=%x\n",cmd_arg_addr,addr_offset);
            //fprintf(dbgUI_out, "module=%s\n",addr2module);

          }
          //ex: load -tf loadmem2.txt -n DCU_Mem
          int ret;
          while(!fin.eof())//當還沒有讀到檔尾時
          {
            fin >> mem_read[dataCount];
            //cout << "此時的dataCount為：" << dataCount << '\n';
            //fprintf(dbgUI_out, "mem_read[%d]=%s\teof=%d\tlength=%d\n",dataCount,mem_read[dataCount],fin.eof(),strlen(mem_read[dataCount]));
            mem_read[dataCount][strlen(mem_read[dataCount])]='\0';
            //int loadstop=0;
            nonbin=0;
            nonhex=0;
            writemem=0;
            //開始分析所讀到的每一字串的資料
            if (strcmp(mem_read[dataCount],"%bin%") == 0 || strcmp(mem_read[dataCount],"//%bin%") == 0)
            {
              binorhex=0;   //就是選binary
              BitNum=8;
              //fprintf(dbgUI_out, "Data type is changed to binary!\n");
              continue;
            }
            else if (strcmp(mem_read[dataCount],"%hex%") == 0 || strcmp(mem_read[dataCount],"//%hex%") == 0)
            {
              binorhex=1;   //就是選hex
              BitNum=2;
              //fprintf(dbgUI_out, "Data type is changed to hex!\n");
              continue;
            }
            else if (mem_read[dataCount][0]=='\n' || mem_read[dataCount][0]==';' ||mem_read[dataCount][0]=='/' || mem_read[dataCount][0]=='%')
            {
              continue;     //忽略不計
            }
            //??
            if (mem_read[dataCount][0]=='\n' || mem_read[dataCount][0]==';' ||mem_read[dataCount][0]=='/')
            {
              //cout << "此行不算\n";
              continue;     //忽略不計
            }
            else if (mem_read[dataCount][0]=='@') //讀到小老鼠    => 開始寫資料
            {
              //cout << "讀到小老鼠了\n";
              if ( strlen(mem_read[dataCount]) ==1)
                continue;
              int i=1;
              while(i<strlen(mem_read[dataCount]))
              {
                AddressJump[i-1]=mem_read[dataCount][i];
                i++;
              }
              AddressJump[i-1]='\0';
              //位址錯誤時，考慮要終止程式。
              if (hex2dec(AddressJump) == -1)
              {
                fprintf(dbgUI_out, "%s : Invalid address, ignored.\n",AddressJump);
                continue;
              }
              else
              {
                Ai++;
                writemem=1;
              }
            }
            else if (strlen(mem_read[dataCount])!=BitNum)
            {
              if (strlen(mem_read[dataCount])!=0)
                //cout << "invalid data read!\n";  //因為資料一定要固定長度(2or8bits)
                if (!fin.eof())  //檢查沒過，資料不算
                  continue;
            }
            //檢查資料binary資料
            else if (binorhex==0)  //就是bin的時候
            {
              for (i=0;i<BitNum;i++)
              {
                if(mem_read[dataCount][i] !='0' && mem_read[dataCount][i]!='1')
                {
                  //cout << "invalid data read!\n";  //因為資料一定要0或1
                  nonbin=1;
                }
              }
              if (nonbin==1 &&  !fin.eof())  //檢查沒過，資料不算
              {
                continue;
              }
              else
              {
                //cout << "檢查OK！\n";
                dataCount++;
              }
            }
            //檢查資料hex資料
            else if (binorhex==1)  //就是hex的時候
            {
              if ( hex2dec(mem_read[dataCount]) == -1 )
              {
                //cout << "invalid data read!\n";  //因為資料一定要hex
                nonhex=1;
              }
              if (nonhex==1 && !fin.eof())  //檢查沒過，資料不算
              {
                continue;
              }
              else
              {
                //cout << "檢查OK！\n";
                dataCount++;
              }
            }
            if ((writemem ==1 || fin.eof() ==1) && !load_fail)     //寫資料    1.讀到@ 2.讀到EOF
            {
              Bl=dataCount-dataCountLast;
              if (Ai==1 && Bl==0)   //第一行寫@XX，不做寫的動作。
              {
                Addr_next=hex2dec(AddressJump);   //寫位址一定是hex
                continue;
              }
              else if (Bl==0)        //Bl=0時，就不用寫資料了
              {
                Addr_next=hex2dec(AddressJump);   //寫位址一定是hex
                continue;
              }
              BYTE  *data_load;     //buffer大小
              data_load = new BYTE[Bl];
              if (binorhex==0)  //binary時
              {
                for (i=0;i<Bl;i++)
                {
                  data_load[i] = bin2dec(mem_read[i+Bl_sum]);
                }
              }
              if (binorhex==1)  //hex時
              {
                for (i=0;i<Bl;i++)
                {
                  data_load[i] = hex2dec(mem_read[i+Bl_sum]);
                }
              }
              /*                      fprintf(dbgUI_out, "\n本次寫進位址%0x的資料共%d筆，依序為：\n",Addr_next,Bl);
                                    for (i=0;i<Bl;i++)
                                    {
                                        fprintf(dbgUI_out, "%0x\t",data_load[i]);
                                    }                      
                                    */
              //cout << '\n';
              if(loadAddr==1)
              {
                strcpy(cmd_arg_name,addr2module);
                Addr_next=addr_offset;
              }
              if (!R_Bus_Mapping_Flag)
              {
                ret=CDebugImp::memWrite(cmd_arg_name, data_load, Addr_next,Bl);
                delete [] data_load;
              }
              else if (R_Bus_Mapping_Flag)
                //ex: load -tf loadmem2.txt  -a 0x00002379
              {
                if (Bl%4!=0)
                {
                  fprintf(dbgUI_out, "Error!! data length must be multiple of 4.\n");
                  //                              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
                  load_fail=1;
                }
                else
                {
                  BYTE *data_load_map;     //buffer大小
                  ULONG data_load_map2;
                  int match=0;
                  for(int k=0;k<Bl/4;k++)
                  {
                    //fprintf(dbgUI_out, "第%d次寫資料\n",k);
                    data_load_map=new BYTE[4];
                    for (j=0;j<4;j++)
                    {
                      data_load_map[j]=data_load[4*k+j];
                      //fprintf(dbgUI_out, "要寫的資料是:data_load_map[%d]=%x\n",j,data_load_map[j]);
                    }
                    data_load_map2=(((unsigned int)data_load_map[3])<<24)|
                                   (((unsigned int)data_load_map[2])<<16)|
                                   (((unsigned int)data_load_map[1])<<8) |
                                   (((unsigned int)data_load_map[0]));
                    //fprintf(dbgUI_out, "疊在一起後是%x \n",data_load_map2);
                    //fprintf(dbgUI_out, "data_load_map2 is : %d \n",data_load_map2);
                    int index_n;
                    int findReg;
                    findReg=addr2reg(cmd_arg_addr, &p_aRegTable, reg_name);
                    if (findReg==-1)
                    {
                      fprintf(dbgUI_out, "Can't find register at address %x.",cmd_arg_addr);
                    }
                    else
                    {
                      //fprintf(dbgUI_out, "Find register %s\n",reg_name);
                      //fprintf(dbgUI_out, "Found!!!!!! when index_n=%d\n",index_n);
                      fprintf(dbgUI_out, "This part is not completely finished yet??");
                      (*p_aRegTable)->write(data_load_map2);     //寫資料
                      match++;
                    }
                    cmd_arg_addr+=4;
                  }
                  //fprintf(dbgUI_out, "\nFinal match=%d\t",match);
                  if (match==0) //看看是否有找到名字相符的
                  {
                    fprintf(dbgUI_out, "No matched register name found, and no data is written.\n");
                    load_fail=1;
                  }
                  delete [] data_load_map;
                }
              } //end of rbus mapping
              //cout << "做完迴圈了\n";   //delete [] data_load;    //沒有delete!!
              //end of writing data
              if (ret==TB_ERROR)
              {
                fprintf(dbgUI_out, "Error encountered when writing data.\n");
                load_fail=1;
              }
              dataCountLast=dataCount;
              if (fin.eof() !=1)
                Addr_next=hex2dec(AddressJump);
              Bl_sum+=Bl;
            }
            //else if (mem_read[dataCount][0]=='@') //忘了這行什麼意思
            //  continue;
          }
          fin.close();
        }
      }
      else
      {
        load_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }

      if(load_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // loadimg ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "loadimg") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  loadimg [-f image_file] [-size width height] [-n module_name] [-i index]\n"
              "Description: \n"
              "  Load image file to memory. \n"
              "Options: \n"
              "  -f:   Binary image file \n"
              "  -size:Image size \n"
              "  -n:   Target module \n"
              "  -i:   Target index. The memory controller has a total picture set of 64. \n"
              "Reference command:\n"
              "  loadimg -f silent_cif.yuv -size 352 288 -n DCU_Mem -i 0\n"
              "    Load image data from \"silent_cif.yuv\" to DCU_Mem index 0.\n");
    }
    else
    {
      int loadimg_fail=0;

      if(arg_num==9 && strlen(cmd_arg_file_b) && strlen(cmd_arg_name) && cmd_arg_index!=-1 && cmd_arg_width!=-1 && cmd_arg_height!=-1 )
      {
        FILE  *image_file;
        BYTE  *data;                      //buffer大小
        int   i=0;
        image_file = fopen(cmd_arg_file_b, "rb");
        if(!image_file)
        {
          fprintf(dbgUI_out, "%s : No such file or directory.\n",cmd_arg_file_b);
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          loadimg_fail=1;
        }
        if(!loadimg_fail)
        {
          data = new BYTE[cmd_arg_width*cmd_arg_height];
          while(i<cmd_arg_width*cmd_arg_height)
            data[i++] = fgetc(image_file);
          int ret;
          ret=CDebugImp::memImgLoad( cmd_arg_name, cmd_arg_index, data, cmd_arg_width,cmd_arg_height );
          delete [] data;
          fclose(image_file);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when loading image data.\n");
            loadimg_fail=1;
          }
        }
      }
      else
      {
        loadimg_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }

      if(loadimg_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // store ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "store") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  store [-n module_name -a address] [-m memory_mapping address] \n"
              "        [-l length] [-f binary_file] [-tf text_file]  [-b] \n"
              "        [-c comments]\n"
              "Description: \n"
              "  Store data to file.\n"
              "Options: \n"
              "  -n:   Module name \n"
              "  -a:   Address with in the module \n"
              "  -m:   Physical address \n"
              "  -l:   Length of memory to be saved size \n"
              "  -f:   Binary file output \n"
              "  -tf:  Text file output \n"
              "  -b:   [For text mode output] Switches to big endian mode for \n"
              "        text file output \n"
              "  -c:   [For text mode output] Comments. Anything that follows \n"
              "        \"-c\" is regarded as comments and stuffed into the first \n"
              "        line of the output.\n"
              "Reference command:\n"
              "  store -n DCU_Mem -a 0 -l 128 -f  savedata.txt\n"
              "    Store 128 bytes of from DCU_Mem address 0 data to \"savedata.txt\".\n"
              "  store -n DCU_Mem -a 0 -l 128 -tf  savedata.txt\n"
              "    Store 128 bytes of from DCU_Mem address 0 data to \"savedata.txt\"\n"
              "    in text mode \n"
              "  store -m 0x10000000 -l 128 -tf  savedata.txt -b -c 0x10000000\n"
              "    Store 128 bytes data starting from physical address 0 to \"savedata.txt\"\n"
              "    in big endian text mode with the comment of \"0x10000000\"at start.\n");
    }
    else
    {

      int store_fail=0;
      if((arg_num==6 || arg_num==8 ) && strlen(cmd_arg_file_b) && cmd_arg_length!=-1 )
        //store -n ME_Engine -a 0 -l 512 -f tmem.yuv
        //store -m 0x18008000     -l 512 -f tmem.yuv
      {
        FILE  *image_file;
        BYTE  *data;     //buffer大小
        //int   length=str2num(cmd_arg[4]);      //要抓的長度
        int   i=0;
        image_file = fopen(cmd_arg_file_b, "wb");
        if(!image_file)   //好像是在寫時檔案開啟一定沒問題
        {
          fprintf(dbgUI_out, "%s : No such file or directory.\n",cmd_arg_file_b);
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          store_fail=1;
        }
        if(cmd_arg_addr!=-1 && strlen(cmd_arg_name) && (arg_num==8))
          //ex: store -n ME_Engine -a 0    -l 512 -f tmem.yuv
        {
          int ret;
          data = new BYTE[cmd_arg_length];
          ret=CDebugImp::memRead(cmd_arg_name ,data, cmd_arg_addr, cmd_arg_length);
          while(i<cmd_arg_length)
            fputc( data[i++], image_file);
          fclose(image_file);
          delete [] data;
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when reading data.\n");
            store_fail=1;
          }
        }
        else if(cmd_arg_addr_m!=-1 && (arg_num==6))
          //ex: store -m 0x18008000 -l 512 -f tmem.yuv
        {
          //此區域需尋找register 讀資料 並依長度找下一個register
          int findReg=0;
          char reg_name[40];
          if (cmd_arg_length%4!=0)
          {
            fprintf(dbgUI_out, "Data length must be multiple of 4.\n");
            //                  fprintf(dbgUI_out, "The command is NOT accomplished.\n");
            store_fail=1;
          }
          else
          {
            ULONG data;
            for (int i=0;i<cmd_arg_length/4;i++)
            {
              int index_n;
              findReg=addr2reg(cmd_arg_addr_m, &p_aRegTable, reg_name);
              if (findReg==-1)
              {
                fprintf(dbgUI_out, "Can't find register at address %x.",cmd_arg_addr_m);
              }
              else
              {
                //fprintf(dbgUI_out, "Find register %s\n",reg_name);
                data=(*p_aRegTable)->read();
                //fprintf(dbgUI_out, "Get register value= %x\n",IRegBase::m_regTable[index_n]->read());
                fputc( data, image_file);
                /*if (ret==TB_ERROR)
                {
                    fprintf(dbgUI_out, "Error encountered when reading data.\n");
                    store_fail=1;
                }*/
              }
              cmd_arg_addr_m+=4;
            }
            fclose(image_file);
          }
        }
      }
      else if(arg_num>=5 && strlen(cmd_arg_file_t) && cmd_arg_length!=-1 )
        //store -n DCU_Mem    -a 0 -l 128 -tf savedata.txt -b -comment this is a DVR
        //store -m 0x18008000      -l 128 -tf savedata.txt    -comment this is a DVR
      {
        FILE  *image_file;
        BYTE  *data;     //buffer大小
        int   i=0;
        image_file = fopen(cmd_arg_file_t, "aw");
        if(!image_file)   //好像是在寫時檔案開啟一定沒問題
        {
          fprintf(dbgUI_out, "%s : No such file or directory.\n",cmd_arg_file_t);
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          store_fail=1;
        }
        int ret;
        if(cmd_arg_addr!=-1 && strlen(cmd_arg_name) && (arg_num>=8))
          //ex: store -n DCU_Mem    -a 0 -l 128 -tf savedata.txt -b -comment this is a DVR
        {

          data = new BYTE[cmd_arg_length];
          ret=CDebugImp::memRead(cmd_arg_name ,data, cmd_arg_addr, cmd_arg_length);
        }
        else if(cmd_arg_addr_m!=-1 && (arg_num>=6))
          //ex: store -m 0x18008000      -l 128 -tf savedata.txt    -comment this is a DVR
        {
          if (cmd_arg_length%4!=0)
          {
            fprintf(dbgUI_out, "Data length must be multiple of 4.\n");
            //                  fprintf(dbgUI_out, "The command is NOT accomplished.\n");
            store_fail=1;
          }
          else
          {
            //此區域需尋找register
            int findReg=0;
            int index_n;
            char reg_name[40];
            findReg=addr2reg(cmd_arg_addr_m, &p_aRegTable, reg_name);
            if (findReg==-1)
            {
              fprintf(dbgUI_out, "Can't find register at address %x.",cmd_arg_addr_m);
            }
            else
            {
              if (!store_fail && arg_num > 7 && cmd_arg_cmt_flag)       //加上comment
              {
                fputs(cmd_arg_cmt, image_file);
                fputs("\n", image_file);
              }
              ULONG data;
              for (int i=0;i<cmd_arg_length/4;i++)
              {
                int index_n;
                findReg=addr2reg(cmd_arg_addr_m, &p_aRegTable, reg_name);
                if (findReg==-1)
                {
                  fprintf(dbgUI_out, "Can't find register at address %x.",cmd_arg_addr_m);
                }
                else
                {
                  //fprintf(dbgUI_out, "Find register %s\n",reg_name);
                  data=(*p_aRegTable)->read();
                  //fprintf(dbgUI_out, "Get register value= %x\n",IRegBase::m_regTable[index_n]->read());
                  fprintf(image_file,"%0.8x",data);
                  /*if (ret==TB_ERROR)
                  {
                      fprintf(dbgUI_out, "Error encountered when reading data.\n");
                      store_fail=1;
                  }*/
                }
                fputc( '\n', image_file);
                cmd_arg_addr_m+=4;
              }
              fclose(image_file);
            }
          }
        }
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when reading data.\n");
          store_fail=1;
          fclose(image_file);
          delete [] data;
        }

        //for (i=0;i<cmd_arg_length;i++)
        //fprintf(dbgUI_out, "讀出來的第%d筆資料是：%d\n",i,data[i]);

        //ex: store -n DCU_Mem    -a 0 -l 128 -tf savedata.txt -b -comment this is a DVR
        if (!memory_mapping_flag && !store_fail && arg_num > 7 && cmd_arg_cmt_flag)       //加上comment
        {
          fputs(cmd_arg_cmt, image_file);
          fputs("\n", image_file);
        }

        if (!memory_mapping_flag && !store_fail && arg_num > 7 && cmd_arg_bigend_flag)    // Big-endian時
        {
          fputs("// Big endian", image_file);
          fputs("\n", image_file);
          i=0;
          while(i<cmd_arg_length)
          {
            //fprintf(dbgUI_out, "將要寫進的第%d筆資料是：%0.2x\n",i,data[i]);
            fprintf( image_file,"%0.2x",data[i]);
            //fputc( data[i],  image_file);
            if (i%8==7)
              fputc( '\n', image_file);
            else
              fputc( ' ',  image_file);
            i++;
          }
          if (i%8!=0)
            fputs( "\n", image_file);
          fclose(image_file);
          delete [] data;
        }
        else if (!memory_mapping_flag && !store_fail && arg_num >= 7 && !cmd_arg_bigend_flag )    // Little-endian時
        {
          int i=0;
          int Q;
          int R;
          Q=cmd_arg_length/8;
          R=cmd_arg_length%8;
          fputs("// Little endian", image_file);
          fputs("\n", image_file);
          for (int j=1;j<(Q+1);j++)
          {
            for (int k=0;k<8;k++)
            {
              fprintf(image_file,"%0.2x",data[8*j-k-1]);
              //fprintf(dbgUI_out, "現在要存%0.2x\t",data[8*j-k-1]);
              if (k!=7)
                fputc( ' ',  image_file);
            }
            fputc( '\n', image_file);
          }
          if(R!=0)
          {
            for (j=0;j<(8-R);j++)
            {
              fprintf( image_file,"%s","cd");
              fputc( ' ',  image_file);
            }
            for (j=8-R;j<8;j++)
            {
              fprintf(image_file,"%0.2x",data[8*(Q+1)-j-1]);
              //fprintf(dbgUI_out, "現在要存%0.2x\t",data[8*(Q+1)-j-1]);
              fputc( ' ',  image_file);
            }
            fputc( '\n', image_file);
          }
          fclose(image_file);
          delete [] data;
        }
      }
      else
      {
        store_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }

      if(store_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // storeimg ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "storeimg") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  storeimg [-n module_name] [-i index] [-size width height]\n"
              "        [-f binary_file] [-tf text_file] [-b] [-c comments]\n"
              "Description: \n"
              "  Store image data to file.\n"
              "Options: \n"
              "  -n:   Module name \n"
              "  -i:   Index of the image \n"
              "  -size:Size of the image to be saved\n"
              "  -f:   Binary file output \n"
              "  -tf:  Text file output \n"
              "  -b:   [For text mode output] Switches to big endian mode for \n"
              "        text file output \n"
              "  -c:   [For text mode output] Comments. Anything that follows \n"
              "        \"-c\" is regarded as comments and stuffed into the first \n"
              "        line of the output.\n"
              "Reference command:\n"
              "  storeimg -n DCU_Mem -i 0 -size 352 288 -f savedata.raw\n"
              "    Store image data from DCU_Mem index 0 to \"savedata.raw\".\n"
              "  storeimg -n DCU_Mem -i 0 -size 352 288 -tf savedata.txt\n"
              "    Store image data from DCU_Mem index 0 to \"savedata.raw\"\n"
              "    in text mode \n"
              "  storeimg -n DCU_Mem -i 0 -size 352 288 -tf savedata.txt -b -c target frame\n"
              "    Store image data from DCU_Mem index 0 to \"savedata.txt\"\n"
              "    in big endian text mode with the comment of \"target frame\"at start.\n");

    }
    else
    {
      int storeimg_fail=0;

      if(arg_num==9 && strlen(cmd_arg_file_b) && strlen(cmd_arg_name) && cmd_arg_index!=-1 && cmd_arg_width!=-1 && cmd_arg_height!=-1 )
        //storeimg -n DCU_Mem -i 0 -size 352 288 -f silent_bak.yuv   => 9
      {
        FILE  *image_file;
        BYTE  *data;     //buffer大小
        int   i=0;
        image_file = fopen(cmd_arg_file_b, "wb");
        if(!image_file)       //好像是在寫時檔案開啟一定沒問題
        {
          fprintf(dbgUI_out, "%s : No such file or directory.\n",cmd_arg_file_b);
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          storeimg_fail=1;
        }
        data = new BYTE[cmd_arg_width*cmd_arg_height];
        int ret;
        ret=CDebugImp::memImgStore(cmd_arg_name,cmd_arg_index, data, cmd_arg_width,cmd_arg_height);
        while(i<cmd_arg_width*cmd_arg_height)
          fputc(data[i++], image_file);
        fclose(image_file);
        delete [] data;
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when storing image data.\n");
          storeimg_fail=1;
        }
      }
      else if(arg_num>=9 && strlen(cmd_arg_file_t) && strlen(cmd_arg_name) && cmd_arg_index!=-1 && cmd_arg_width!=-1 && cmd_arg_height!=-1 )
        //storeimg -n DCU_Mem -i 0 -size 352 288 -tf out.txt -b -comment this is DVR  => 9+
      {
        FILE  *image_file;
        BYTE  *data;     //buffer大小
        int   i=0;
        image_file = fopen(cmd_arg_file_t, "aw");
        if(!image_file)   //好像是在寫時檔案開啟一定沒問題
        {
          fprintf(dbgUI_out, "%s : No such file or directory.\n",cmd_arg_file_t);
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          storeimg_fail=1;
        }
        data = new BYTE[cmd_arg_width*cmd_arg_height];
        int ret;
        ret=CDebugImp::memImgStore(cmd_arg_name,cmd_arg_index, data, cmd_arg_width,cmd_arg_height);
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when reading data.\n");
          storeimg_fail=1;
          fclose(image_file);
          delete [] data;
        }

        //for (i=0;i<cmd_arg_length;i++)
        //fprintf(dbgUI_out, "讀出來的第%d筆資料是：%d\n",i,data[i]);

        if (!storeimg_fail && arg_num > 9 && cmd_arg_cmt_flag)    //加上comment
        {
          fputs(cmd_arg_cmt, image_file);
          fputs("\n", image_file);
        }

        if (!storeimg_fail && arg_num > 9 && cmd_arg_bigend_flag) // Big-endian時
        {
          fputs("// Big endian", image_file);
          fputs("\n", image_file);
          i=0;
          while(i<cmd_arg_width*cmd_arg_height)
          {
            //fprintf(dbgUI_out, "將要寫進的第%d筆資料是：%d\n",i,data[i]);
            fprintf(image_file,"%0.2x",data[i]);
            //fputc( data[i],  image_file);
            if (i%8==7)
              fputc( '\n', image_file);
            else
              fputc( ' ',  image_file);
            i++;
          }
          if (i%8!=0)
            fputs( "\n", image_file);
          fclose(image_file);
          delete [] data;
        }
        else if (!storeimg_fail && arg_num >= 9 && !cmd_arg_bigend_flag ) // Little-endian時
        {
          int i=0;
          int Q;
          int R;
          Q=cmd_arg_width*cmd_arg_height/8;
          R=cmd_arg_width*cmd_arg_height%8;
          fputs("// Little endian", image_file);
          fputs("\n", image_file);
          for (int j=1;j<(Q+1);j++)
          {
            for (int k=0;k<8;k++)
            {
              fprintf(image_file,"%0.2x",data[8*j-k-1]);
              //fprintf(dbgUI_out, "現在要存%0x\t",data[8*j-k-1]);
              if (k!=7)
                fputc( ' ',  image_file);
            }
            fputc( '\n', image_file);
          }
          if(R!=0)
          {
            for (j=0;j<(8-R);j++)
            {
              fprintf(image_file,"%s","cd");
              fputc( ' ',  image_file);
            }
            for (j=8-R;j<8;j++)
            {
              fprintf(image_file,"%0.2x",data[8*(Q+1)-j-1]);
              //fprintf(dbgUI_out, "現在要存%0x\t",data[8*(Q+1)-j-1]);
              fputc( ' ',  image_file);
            }
            fputc( '\n', image_file);
          }
          fclose(image_file);
          delete [] data;
        }
      }
      else
      {
        storeimg_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }

      if(storeimg_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // loadprog ////////////////////////////////////////////////////////////////
  // EX: loadprog -n CPU -f file
  else if ( strcmp(cmd_name, "loadprog") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  loadprog [-n module_name] [-f elf_file]\n"
              "Description: \n"
              "  Load ELF program to memory. It uses the ISS to process\n"
              "  the file for input.\n"
              "Options: \n"
              "  -n:   Module name \n"
              "  -f:   ELF file \n"
              "Reference command:\n"
              "  loadprog -n Video_RISC -f test_enc.out\n"
              "    Load program \"test_enc.out\" to memory.\n");
    }
    else
    {
      int loadprog_fail=0, ret;
      if(arg_num==4 && strlen(cmd_arg_file_b) && strlen(cmd_arg_name))
      {
        ret=CDebugImp::progLoad(cmd_arg_name,cmd_arg_file_b);
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when loading pragram data.\n");
          loadprog_fail=1;
        }
      }
      else
      {
        loadprog_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (loadprog_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // setbreak ////////////////////////////////////////////////////////////////
  // EX: setbreak -n DCU_Mem -pc 0x11ff
  else if ( strcmp(cmd_name, "setbreak") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  setbreak -n module_name -pc break_address\n"
              "Description:\n"
              "  Add a breakpoint to a special address. When CPU execute the address, \n"
              "  the simulation stop.\n"
              "Options:\n"
              "  -n:  Module name of the CPU\n"
              "  -pc: Virtual address of the breakpoint\n"
              "Reference command:\n"
              "  setbreak -n cpu0 -pc 0x80000400\n"
              "    Add cpu0 module breakpoint at address 0x80000400.\n");
    }
    else
    {
      int setbreak_fail=0;
      if(arg_num==4 && strlen(cmd_arg_name) && cmd_arg_pc!=-1 )
      {
        int ret;
        ret=CDebugImp::setBreakPoint(cmd_arg_name,cmd_arg_pc);
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when setting breakpoint.\n");
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          setbreak_fail=1;
        }
      }
      else
      {
        setbreak_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }

      if (setbreak_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // setdbgout ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "setdbgout") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  setdbgout -n module_name [on|off] [-f file_log]\n"
              "Description:\n"
              "  Sets the debug output message on/off to file.\n"
              "Options:\n"
              "  -n:  Module name of the CPU\n"
              "  -f:  File output log\n"
              "Reference command:\n"
              "  setdbgout -n Memory_Bus off\n"
              "    Turns off memory bus output messages.\n"
              "  setdbgout -n DCU_Mem on -f test.log\n"
              "    Turns on DCU_Mem output messages and saves them to \"test.log\".\n");
    }
    else
    {
      int setdbgout_fail=0;
      if(arg_num>=3 && strlen(cmd_arg_name))
      {
        int ret;
        int   log_file_idx;
        
        if(arg_num>3 && strlen(cmd_arg_name) && strlen(cmd_arg_file_b))
        {
          for( log_file_idx=0; log_file_idx<10; log_file_idx++)
            if( strcmp(cmd_arg_file_b, log_file[log_file_idx].file_name) == 0)
              break;
          
          if( log_file_idx == 10 )
          {
            for( log_file_idx=0; log_file_idx<10; log_file_idx++)
              if( log_file[log_file_idx].log_out == NULL )
              {
                log_file[log_file_idx].log_out = fopen(cmd_arg_file_b, "aw");
                strcpy( log_file[log_file_idx].file_name, cmd_arg_file_b);
                break;
              }
  
            if(log_file_idx == 10)          
              setdbgout_fail = 1;
          }

          if( setdbgout_fail == 0 )
          {
            if( strcmp(cmd_arg[2], "on") == 0 )
              ret=CDebugImp::setModDebugOut(cmd_arg_name, log_file[log_file_idx].log_out);
            else
              ret=CDebugImp::setModDebugOut(cmd_arg_name, NULL);
          }
        }
        else if(arg_num==3 && strlen(cmd_arg_name))
        {
          if( strcmp(cmd_arg[2], "on") == 0 )
            ret=CDebugImp::setModDebugOut(cmd_arg_name, stdout);
          else
            ret=CDebugImp::setModDebugOut(cmd_arg_name, NULL);
        }
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when setting debug out mode.\n");
          //            fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          setdbgout_fail=1;
        }
      }
      else
      {
        setdbgout_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (setdbgout_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // clrbreak ////////////////////////////////////////////////////////////////
  // EX: clrbreak -n cpu0
  // EX: clrbreak -n cpu0  -pc 0x11ff
  // EX: clrbreak -n cpu0  -i  5
  else if ( strcmp(cmd_name, "clrbreak") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  clrbreak -n module_name [-pc break_address] [-i index]\n"
              "Description:\n"
              "  Clear a breakpoint or all breakpoints.\n"
              "Options:\n"
              "  -n:  Module name of the CPU\n"
              "  -pc: Virtual address of the breakpoint\n"
              "  -i:  Index number of the breakpoint\n"
              "Reference command:\n"
              "  clrbreak -n cpu0\n"
              "    Clear cpu0 module all breakpoints.\n"
              "  clrbreak -n cpu0 -pc 0x80000400\n"
              "    Clear cpu0 module breakpoint of address 0x80000400.\n"
              "  clrbreak -n cpu0 -i 5\n"
              "    Clear cpu0 breakpoint index 5.\n");
    }
    else
    {
      int clrbreak_fail=0;
      if(arg_num>=2 && strlen(cmd_arg_name))
      {
        if (arg_num==2)
          // EX: clrbreak -n cpu0
        {
          int ret;
          ret=CDebugImp::clrBreakPoint(cmd_arg_name);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when clearing breakpoint.\n");
            //                  fprintf(dbgUI_out, "The command is NOT accomplished.\n");
            clrbreak_fail=1;
          }
        }
        else if(arg_num==4 && cmd_arg_pc!=-1 )
          // EX: clrbreak -n cpu0 -pc 0x11ff
        {
          int ret;
          ret=CDebugImp::clearBreakPoint(cmd_arg_name,cmd_arg_pc);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when clearing breakpoint.\n");
            //                  fprintf(dbgUI_out, "The command is NOT accomplished.\n");
            clrbreak_fail=1;
          }
        }
        else if(arg_num==4 && cmd_arg_index!=-1)
          // EX: clrbreak -name cpu0 -i 100
        {
          int ret;
          ret=CDebugImp::clrIdxBreakPoint(cmd_arg_name, cmd_arg_index);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when clearing breakpoint on index.\n");
            clrbreak_fail=1;
          }
        }
        else
          clrbreak_fail=1;
      }
      else
      {
        clrbreak_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (clrbreak_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // showceibreak ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "showceibreak") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  showceibreak -n module_name\n"
              "Description:\n"
              "  List all CEI break commands.\n"
              "Options:\n"
              "  -n:  Module name\n"
              "  -pc: Virtual address of the breakpoint\n"
              "Reference command:\n"
              "  showceibreak -n Video_Engine\n"
              "    List all CEI break commands.\n");
    }
    else
    {
      int showceibreak_fail=0;
      if(arg_num==2 && strlen(cmd_arg_name))
      {
        int ret;
        ret=CDebugImp::showCEIBreak(cmd_arg_name);
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when showing CEI breakpoint.\n");
          showceibreak_fail=1;
        }
      }
      else
      {
        showceibreak_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (showceibreak_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // setceibreak ////////////////////////////////////////////////////////////////
  // EX: setceibreak -n DCU_Mem -code LDMCCIT
  else if ( strcmp(cmd_name, "setceibreak") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  setceibreak -n module_name -code instruction\n"
              "Description:\n"
              "  Sets CEI break instruction.\n"
              "Options:\n"
              "  -n:  Module name\n"
              "  -code: CEI instruction\n"
              "Reference command:\n"
              "  setceibreak -n Video_Engine -code LDMCCIT\n"
              "    Sets break point for LDMCCIT for Video Engine.\n");
    }
    else
    {
      int setceibreak_fail=0;
      if(arg_num==4 && strlen(cmd_arg_name) && strlen(cmd_arg_code))
      {
        int main_opcode;
        int sub_opcode;
        setceibreak_fail=findOpSubop(cmd_arg_code,main_opcode,sub_opcode);
        if (setceibreak_fail!=-1)
        {
          int ret;
          ret=CDebugImp::setCEIBreak(cmd_arg_name,main_opcode,sub_opcode);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when setting CEI breakpoint.\n");
            setceibreak_fail=1;
          }
        }
        else
          setceibreak_fail=1;
      }
      else
      {
        setceibreak_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (setceibreak_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // clrceibreak ////////////////////////////////////////////////////////////////
  // EX: clrceibreak -n DCU_Mem -code LDMCCIT
  else if ( strcmp(cmd_name, "clrceibreak") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  clrceibreak -n module_name -code instruction\n"
              "Description:\n"
              "  Clears CEI break instruction.\n"
              "Options:\n"
              "  -n:  Module name\n"
              "  -code: CEI instruction\n"
              "Reference command:\n"
              "  clrceibreak -n Video_Engine -code LDMCCIT\n"
              "    Clears break point for LDMCCIT for Video Engine.\n");
    }
    else
    {
      int clrceibreak_fail=0;
      if(arg_num==4 && strlen(cmd_arg_name) && strlen(cmd_arg_code))
      {
        int main_opcode;
        int sub_opcode;
        //fprintf(dbgUI_out, "cmd_name is %s\n",cmd_arg[3]);
        clrceibreak_fail=findOpSubop(cmd_arg_code,main_opcode,sub_opcode);
        if (clrceibreak_fail!=-1)
        {
          int ret;
          ret=CDebugImp::clearCEIBreak(cmd_arg_name,main_opcode,sub_opcode);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when clearing CEI breakpoint.\n");
            //                  fprintf(dbgUI_out, "The command is NOT accomplished.\n");
            clrceibreak_fail=1;
          }
        }
        else
        {
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          clrceibreak_fail=1;
        }
      }
      else
      {
        clrceibreak_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (clrceibreak_fail==1)
      {
        quit_script(script_file);
      }
      else
      {
        fprintf(dbgUI_out, "The command is accomplished.\n");
      }
    }
  }


  // showstack ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "showstack") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage:\n"
              "  showstack -n module_name [-l length]\n"
              "Description:\n"
              "  Show stack.\n"
              "Options:\n"
              "  -n:  Module name of the CPU\n"
              "  -l:  Size of the memory to print (default is 256 bytes)\n"
              "Reference command:\n"
              "  showstack -n Video_RISC\n"
              "    Print 256 bytes of the memory data starting from SP register.\n"
              "  showstack -n Video_RISC -l 1024\n"
              "    Print 1024 bytes of the memory data starting from SP register.\n");
    }
    else
    {
      int ret=0;

      if( (arg_num==2 ||arg_num==4 ) && strlen(cmd_arg_name))
      {
        if( arg_num == 2 )
          ret = CDebugImp::showStack( cmd_arg_name, 256, msg_out);
        else
          ret = CDebugImp::showStack( cmd_arg_name, cmd_arg_length, msg_out);
      }
      else
        ret = TB_ERROR;

      if (ret == TB_ERROR)
      {
        fprintf(dbgUI_out, illegal_parameter_string);
        quit_script(script_file);
      }
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }


  // showcpureg ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "showcpureg") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage:\n"
              "  showcpureg -n module_name [-g group_name] [-i group_number]\n"
              "Description:\n"
              "  Show CPU registers.\n"
              "Options:\n"
              "  -n:  Module name of the CPU\n"
              "  -g:  Group name of the module\n"
              "  -i:  Group index number of the module\n"
              "Reference command:\n"
              "  showcpureg -n cpu0\n"
              "    Show available register groups of cpu0 module.\n"
              "  showcpureg -n cpu0 -g GEN\n"
              "    Show cpu0 general purpose group registers.\n"
              "  showcpureg -n cpu0 -i 2\n"
              "    Show cpu0 group 2 registers (COP0 registers).\n");
    }
    else
    {
      int showcpureg_fail=0;
      if(arg_num>=2 && strlen(cmd_arg_name))
      {
        if (arg_num==2)
          // EX: showcpureg -name DCU_Mem
        {
          int ret;
          ret=CDebugImp::showCPUReg(cmd_arg_name, msg_out);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when showing CPU register.\n");
            //                  fprintf(dbgUI_out, "The command is NOT accomplished.\n");
            showcpureg_fail=1;
          }
        }
        else if(arg_num==4 && strlen(cmd_arg_group))
          // EX: showcpureg -name DCU_Mem -g group_name
        {
          int ret;
          ret=CDebugImp::showCPUReg(cmd_arg_name, cmd_arg_group, msg_out);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when showing CPU register.\n");
            //                  fprintf(dbgUI_out, "The command is NOT accomplished.\n");
            showcpureg_fail=1;
          }
        }
        else if(arg_num==4 && cmd_arg_index!=-1)
          // EX: showcpureg -name DCU_Mem -i 100
        {
          int ret;
          ret=CDebugImp::showCPUReg(cmd_arg_name, cmd_arg_index, msg_out);
          if (ret==TB_ERROR)
          {
            fprintf(dbgUI_out, "Error encountered when showing CPU register.\n");
            //                  fprintf(dbgUI_out, "The command is NOT accomplished.\n");
            showcpureg_fail=1;
          }
        }
        else
        {
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          showcpureg_fail=1;
        }
      }
      else
      {
        showcpureg_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (showcpureg_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // setreg ////////////////////////////////////////////////////////////////
  // EX: setreg -name DCU_Mem -r ME_CTRL -h 1f
  // EX: setreg -name DCU_Mem -r ME_CTRL -d 20
  else if ( strcmp(cmd_name, "setreg") == 0)
  {
    if(cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage:\n"
              "  setcpureg -name CPU_name -r register_name [-d value] [-h value] \n"
              "Description:\n"
              "  Sets CPU registers.\n"
              "Options:\n"
              "  -n:  Module name of the CPU\n"
              "  -r:  Register name of the module\n"
              "  -d:  Decimal value\n"
              "  -h:  Hex value\n"
              "Reference command:\n"
              "  setcpureg -name Video_RISC -r EStatus -d 0x00000010\n"
              "    Show available register groups of cpu0 module.\n");
    }
    else
    {
      int setreg_fail=0;
      if(arg_num==6 && strlen(cmd_arg_name) && strlen(cmd_arg_reg))
      {
        ULONG write_value;
        write_value=(cmd_arg_dec_flag)?cmd_arg_dec:cmd_arg_hex;
        //fprintf(dbgUI_out, "write_value=%d\n",write_value);
        //fprintf(dbgUI_out, "write_value=%h\n",write_value);
        int ret;
        ret=CDebugImp::setCPUReg(cmd_arg_name, cmd_arg_reg, write_value);
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when setting register.\n");
          //              fprintf(dbgUI_out, "The command is NOT accomplished.\n");
          setreg_fail=1;
        }
      }
      else
      {
        setreg_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (setreg_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // showbreak ////////////////////////////////////////////////////////////////
  // EX: showbreak -n DCU_Mem
  else if ( strcmp(cmd_name, "showbreak") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  showbreak -n module_name\n"
              "Description:\n"
              "  List all breakpoints of the CPU.\n"
              "Options:\n"
              "  -n:  Module name of the CPU\n"
              "Reference command:\n"
              "  showbreak -n cpu0\n"
              "    Shows all breakpoints of the cpu0.\n");
    }
    else
    {
      int showbreak_fail=0;
      if(arg_num==2 && strlen(cmd_arg_name))
      {
        int ret;
        ret=CDebugImp::showCPUBreak(cmd_arg_name);
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when showing breakpoint.\n");
          showbreak_fail=1;
        }
      }
      else
      {
        showbreak_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (showbreak_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // setimgpar ////////////////////////////////////////////////////////////////
  // EX: setimgpar -name DCU_Mem -i 100 -page 20 -w 128
  else if ( strcmp(cmd_name, "setimgpar") == 0)
  {
    if( cmd_arg_help_flag )
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  setimgpar -name DCU_Mem -i index -page starting_page -w width_scale\n"
              "Description:\n"
              "  Sets the DCU picture set index. Starting page specifies the starting\n"
              "  position of the image. Width scale specifies the width of the image. \n"
              "  Width_scale=1, Image=0~256. Width_scale=2, Image=257~512. ...etc. \n"
              "Options:\n"
              "  -name:Module name of the DCU\n"
              "  -i:   Target index\n"
              "  -page:Initial page\n"
              "  -w:   Width scale\n"
              "Reference command:\n"
              "  setimgpar -name DCU_Mem -i 34 -page 20 -w 1\n"
              "    Set image parameter on module DCU_Mem with index=34, page=20 and  \n"
              "    width_scale=1.\n");
    }
    else
    {
      int setimgpar_fail=0;
      if(arg_num==8 && strlen(cmd_arg_name) && cmd_arg_index!=-1 && cmd_arg_page!=-1 && cmd_arg_width!=-1)
      {
        int ret;
        ret=CDebugImp::memImgSet(cmd_arg_name,cmd_arg_index,cmd_arg_page,cmd_arg_width);
        if (ret==TB_ERROR)
        {
          fprintf(dbgUI_out, "Error encountered when setting image parameter.\n");
          setimgpar_fail=1;
        }
      }
      else
      {
        setimgpar_fail=1;
        if (arg_num>=1 && !cmd_arg_help_flag)
          fprintf(dbgUI_out, illegal_parameter_string);
      }
      if (setimgpar_fail==1)
        quit_script(script_file);
      else
        fprintf(dbgUI_out, "The command is accomplished.\n");
    }
  }

  // script ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "script") == 0 || strcmp(cmd_name, "s") == 0)
  {
    if( cmd_arg_help_flag)
    {
      fprintf(dbgUI_out,  "Usage: \n"
              "  script script_file\n"
              "Description:\n"
              "  Executes all the commands in the script file.\n"
              "Options:\n"
              "  script_file: the script_file\n"
              "Reference command:\n"
              "  script script.txt\n"
              "    For loading script.txt file.\n");
    }
    else
    {
      int script_help=0;
      if(arg_num==1 && !cmd_arg_help_flag)
      {
        if( (*script_file) != NULL )
        {
          cout << "Double script call!! Not allowed!!\n";
        }
        else
        {
          (*script_file) = fopen(cmd_arg[0], "r");
          if( (*script_file) == NULL )
            fprintf(dbgUI_out, "%s : No such file or directory.\n",cmd_arg[0]);
          else
            fprintf(dbgUI_out, "File %s is opened. Reading commends.........\n",cmd_arg[0]);

        }
      }
      else if(arg_num==0)
      {
        if( (*script_file) != NULL )
        {
          cout << "Double script call!! Not allowed!!\n";
        }
        else
        {
          fprintf(dbgUI_out, "No script file specfied. Load the default script file: script.txt\n");
          (*script_file) = fopen("script.txt", "r");
          if( (*script_file) == NULL )
            fprintf(dbgUI_out, "File script.txt can not be found.\n");
          else
            fprintf(dbgUI_out, "File script.txt is opened. Reading commends.........\n");
        }
      }
      else
      {
        fprintf(dbgUI_out, illegal_parameter_string);
        script_help=1;
      }
    }
  }


  // quit ////////////////////////////////////////////////////////////////
  else if ( strcmp(cmd_name, "quit") == 0 || strcmp(cmd_name, "exit") == 0 || strcmp(cmd_name, "q") == 0 || strcmp(cmd_name, "0") == 0)
  {
    //確認是否setdbgout開的檔案是否都已關閉。
    for (int i=0;i<10;i++)
      if( log_file[i].log_out != NULL )
        fclose(log_file[i].log_out);

    fprintf( stderr, "See you next time. Bye~\n");
    return TB_DEBUG_STOP;
  }

  else if ( strcmp(cmd_name, "\0") == 0 )   //按Enter => 沒事發生，故什麼事也沒做。
  {
  }

  else if ( strcmp(cmd_name, "cat") == 0 )
  {
    char cmd_line2[40];
    strcpy(cmd_line2,"type ");
    strcat(cmd_line2,cmd_arg[0]);
    system(cmd_line2);
  }

  else if ( strcmp(cmd_name, "ll") == 0 || strcmp(cmd_name, "ls") == 0 )
  {
    system("dir");
  }

  else if ( strcmp(cmd_name, "hex2dec") == 0 )
  {
    int convert_val;
    convert_val = hex2dec(cmd_arg[0]);
    fprintf(dbgUI_out, "%s  hex2dec =>   %d\n",cmd_arg[0],convert_val);
  }

  else if ( strcmp(cmd_name, "str2num") == 0 )
  {
    int convert_val;
    convert_val = str2num(cmd_arg[0]);
    fprintf(dbgUI_out, "%s  str2num =>   %d\n",cmd_arg[0],convert_val);
  }

  else if ( strcmp(cmd_name, "dec2hex") == 0 )
  {
    fprintf(dbgUI_out, "%s  dec2hex =>   %x\n",cmd_arg[0],atoi(cmd_arg[0]));
  }

  else if ( strcmp(cmd_name, "p") == 0 )
  {
    system("pause");
  }

  else if ( strcmp(cmd_name, "pauseon") == 0 )
  {
    pause=1;
    fprintf(dbgUI_out, "Pause on mode.\n");
  }

  else if ( strcmp(cmd_name, "pauseoff") == 0 )
  {
    pause=0;
    fprintf(dbgUI_out, "Pause off mode.\n");
  }

  // for checking ////////////////////////////////////////////////////////////////
  else      //for others input commands
  {
    int valid_cmd;
    valid_cmd=system(cmd_line);
    if(valid_cmd)
    {
      //fprintf(dbgUI_out, "%s: Command not found.\n",cmd_name);
      fprintf(dbgUI_out, "For help on the debugging interface, enter:  help or ?\n");
    }
  }

  fflush(msg_out);
  
  if( msg_out != NULL && msg_out != dbgUI_out)
    fclose(msg_out);

  return TB_DEBUG_DONE;
}


int pow(int t1,int t2)  //算t1的t2次方
{
  int ddd=1;
  for (int i=0;i<t2;i++)
    ddd*=t1;
  return ddd;
}

int bin2dec(char* bbb)  //只支援一個byte長
{
  int ddd=0;
  ddd=(bbb[0]-48)*128+(bbb[1]-48)*64+(bbb[2]-48)*32+(bbb[3]-48)*16+(bbb[4]-48)*8+(bbb[5]-48)*4+(bbb[6]-48)*2+(bbb[7]-48)*1;
  return ddd;
}

ULONG str2num(char* sss)
{
  ULONG nnn=0;
  if (strncmp(sss,"0x",2)==0)
    nnn=hex2dec(sss);
  else
    nnn=atoi(sss);
  return nnn;
}

ULONG hex2dec(char* hhh)  //只支援到FFF_FFFF (7個F)
{
  ULONG   val;
  ULONG   result=0;
  int     length=strlen(hhh);

  for (int i=0;i<length;i++)
  {
    switch(hhh[i])
    {
    case '0':
    case 'x':
    case 'X':
      val=0;
      break;
    case '1':
      val=1;
      break;
    case '2':
      val=2;
      break;
    case '3':
      val=3;
      break;
    case '4':
      val=4;
      break;
    case '5':
      val=5;
      break;
    case '6':
      val=6;
      break;
    case '7':
      val=7;
      break;
    case '8':
      val=8;
      break;
    case '9':
      val=9;
      break;
    case 'a':
    case 'A':
      val=10;
      break;
    case 'b':
    case 'B':
      val=11;
      break;
    case 'c':
    case 'C':
      val=12;
      break;
    case 'd':
    case 'D':
      val=13;
      break;
    case 'e':
    case 'E':
      val=14;
      break;
    case 'f':
    case 'F':
      val=15;
      break;
    default:
      return -1;
    }
    result = (result << 4) + val;
    //        result += val*pow(16,length-i-1);
  }
  return result;
}

int addr2reg(int& addr, IRegBasePtr **p_reg, char* reg_name)
{
  int             regCount;
  
  for( int dev_i=0; dev_i<CDebugImp::m_deviceCount; dev_i++ )
  {
    (*p_reg) = CDebugImp::m_deviceTable[dev_i]->getRegTable(regCount);
    for( int reg_i=0; reg_i < regCount; reg_i++, (*p_reg)++)
    {
      if( addr==(*p_reg)[0]->m_address )
      {
        strcpy(reg_name,(*p_reg)[0]->m_registerName);
        return 0;  // register found
      }
    }
  }
  return -1; // register not found
  
/*  int totalReg=IRegBase::m_regCount;
  int foundRegister=0;
  for (int i=0;i<totalReg;i++)
  {
    if (addr==IRegBase::m_regTable[i]->m_address)
    {
      //fprintf(dbgUI_out, "found register.\n");
      //fprintf(dbgUI_out, "編號%d\t位址%x\t名字%s\n",i,IRegBase::m_regTable[i]->m_address,IRegBase::m_regTable[i]->m_registerName);
      strcpy(reg_name,IRegBase::m_regTable[i]->m_registerName);
      index_n=i;
      foundRegister=1;
    }
  }
  if (foundRegister==0)
  {
    return -1;
  }
  return 0;*/
}


