// reading a text file
#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>
#include <unistd.h>
using namespace std;

// GLOBAL ARRAY
//Arrays that hold the string containing that instructions
// i.e ori_array[0] = ori $1, $1, 0xfffe
// I sort all the lines by instruction and parse them

string label_array[100];
string ori_array[100];
string sltiu_array[100];
string addi_array[100];
string slti_array[100];
string addiu_array[100];
string andi_array[100];
string add_array[100];
string slt_array[100];
string sub_array[100];
string lui_array[100];
string nor_array[100];
string srl_array[100];
string sll_array[100];
string subu_array[100];
string sltu_array[100];
string addu_array[100];
string or_array[100];
string and_array[100];



int instr_index[32];    // Temp
int label_index = 0;    

string toBin_5(string y);
string I_type_parse(int i,string s[],string op);
string R_type_parse(int i,string s[],string funct);
int main () {
#define base 400000
  string line;  //
  string label = ":";
  string ori = "ori ";
  string sltiu = "sltiu ";
  string addi = "addi ";
  string slti = "slti ";
  string addiu = "addiu ";
  string andi = "andi ";
  string add = "add ";
  string slt = "slt ";
  string sub = "sub ";
  string lui = "lui ";
  string nor = "nor ";
  string srl = "srl ";
  string sll = "sll ";
  string subu = "subu ";
  string sltu = "sltu ";
  string addu = "addu ";
  string or_ = "or ";
  string and_ = "and ";



  string ori_op = "001101";
  string sltiu_op = "001011";
  string addi_op ="001000";
  string slti_op = "001010";
  string addiu_op = "001001";
  string andi_op = "001100";
  string lui_op = "001111";



  string add_funct = "20";
  string slt_funct = "2A";
  string sub_funct = "22";
  string nor_funct = "27";
  string srl_funct = "02";
  string sll_funct = "00";
  string subu_funct = "23";
  string sltu_funct = "2B";
  string addu_funct = "21";
  string or_funct = "25";
  string and_funct = "24";
// Address location where instrcution was found
  int label_addr[100];
  int ori_addr[100];
  int sltiu_addr[100];
  int addi_addr[100];
  int slti_addr[100];
  int addiu_addr[100];
  int andi_addr[100];
  int add_addr[100];
  int slt_addr[100];
  int sub_addr[100];
  int lui_addr[100];
  int nor_addr[100];
  int srl_addr[100];
  int sll_addr[100];
  int subu_addr[100];
  int sltu_addr[100];
  int addu_addr[100];
  int or_addr[100];
  int and_addr[100];




  for(int i = 0; i<30; i++){
    instr_index[i] = 0;
  }
  
  size_t ori_size;
  size_t sltiu_size;
  size_t addi_size;
  size_t slti_size;
  size_t addiu_size;
  size_t andi_size;
  size_t add_size;
  size_t slt_size;
  size_t sub_size;
  size_t lui_size;
  size_t nor_size;
  size_t srl_size;
  size_t sll_size;
  size_t subu_size;
  size_t sltu_size;
  size_t addu_size;
  size_t or_size;
  size_t and_size;
  size_t label_size;

 

// Grab all instructions and labels
  ifstream myfile ("test.txt");
  while (myfile.is_open()){  


for(int addr = 1;!myfile.eof();addr++){

        getline (myfile,line);
       
        ori_size = line.find(ori);
        sltiu_size = line.find(sltiu);
        addi_size = line.find(addi);
        slti_size = line.find(slti);
        addiu_size = line.find(addiu); 
        andi_size = line.find(andi);
        add_size = line.find(add);
        slt_size = line.find(slt);
        sub_size = line.find(sub);
        lui_size = line.find(lui);
        nor_size = line.find(nor);
        srl_size = line.find(srl);
        sll_size = line.find(sll);
        subu_size = line.find(subu);
        sltu_size = line.find(sltu);
        addu_size = line.find(addu);
        or_size = line.find(or_);
        and_size = line.find(and_);
        label_size = line.find(label);
       
          if(label_size!=std::string::npos){
            label_array[label_index] = line;
            cout<<label_array[label_index];
            label_addr[label_index] = base+addr;
            cout<<" <= label at " <<label_addr[label_index]<<endl;
            label_index++;
          }

          

          if(addi_size!=std::string::npos){
            addi_array[instr_index[3]] = line;
            cout<<I_type_parse(instr_index[3],addi_array,addi_op);
            addi_addr[instr_index[3]] = base+addr;   
            cout << " <= addi at address " <<addi_addr[instr_index[3]]<<"\n";       
            instr_index[3]++;
          }

          if(slti_size!=std::string::npos){
            slti_array[instr_index[4]] = line;
            cout<<I_type_parse(instr_index[4],slti_array,slti_op);
            slti_addr[instr_index[4]] = base+addr;   
            cout << " <= slti at address " <<slti_addr[instr_index[4]]<<"\n";       
            instr_index[4]++;
          }

          if(addiu_size!=std::string::npos){
            addiu_array[instr_index[5]] = line;
            cout<<I_type_parse(instr_index[5],addiu_array,addiu_op);
            addiu_addr[instr_index[5]] = base+addr;   
            cout << " <= addiu at address " <<addiu_addr[instr_index[5]]<<"\n";       
            instr_index[5]++;
          }

          if(andi_size!=std::string::npos){
            andi_array[instr_index[6]] = line;
            cout<<I_type_parse(instr_index[6],andi_array,andi_op);
            andi_addr[instr_index[6]] = base+addr;   
            cout << " <= andi at address " <<andi_addr[instr_index[6]]<<"\n";       
            instr_index[6]++;
          }

          if(add_size!=std::string::npos){
            add_array[instr_index[7]] = line;
            cout<<R_type_parse(instr_index[7],add_array,add_funct);
            add_addr[instr_index[7]] = base+addr;   
            cout << " <= add at address " <<add_addr[instr_index[6]]<<"\n";       
            instr_index[7]++;
          }

          if(slt_size!=std::string::npos){
            slt_array[instr_index[8]] = line;
            cout<<R_type_parse(instr_index[8],slt_array,slt_funct);
            slt_addr[instr_index[8]] = base+addr;   
            cout << " <= slt at address " <<slt_addr[instr_index[8]]<<"\n";       
            instr_index[8]++;
          }

          if(sub_size!=std::string::npos){
            sub_array[instr_index[9]] = line;
            cout<<R_type_parse(instr_index[9],sub_array,sub_funct);
            sub_addr[instr_index[9]] = base+addr;   
            cout << " <= sub at address " <<sub_addr[instr_index[9]]<<"\n";       
            instr_index[9]++;
          }

          if(lui_size!=std::string::npos){
            lui_array[instr_index[10]] = line;
            cout<<I_type_parse(instr_index[10],lui_array,lui_op);
            lui_addr[instr_index[10]] = base+addr;   
            cout << " <= lui at address " <<lui_addr[instr_index[10]]<<"\n";       
            instr_index[10]++;
          }

          if(nor_size!=std::string::npos){
            nor_array[instr_index[11]] = line;
            cout<<R_type_parse(instr_index[11],nor_array,nor_funct);
            nor_addr[instr_index[11]] = base+addr;   
            cout << " <= nor at address " <<nor_addr[instr_index[11]]<<"\n";       
            instr_index[11]++;
          }

          if(srl_size!=std::string::npos){
            srl_array[instr_index[12]] = line;
            cout<<R_type_parse(instr_index[12],srl_array,srl_funct);
            srl_addr[instr_index[12]] = base+addr;   
            cout << " <= srl at address " <<srl_addr[instr_index[12]]<<"\n";       
            instr_index[12]++;
          }

          if(sll_size!=std::string::npos){
            sll_array[instr_index[13]] = line;
            cout<<R_type_parse(instr_index[13],sll_array,sll_funct);
            sll_addr[instr_index[13]] = base+addr;   
            cout << " <= sll at address " <<sll_addr[instr_index[13]]<<"\n";       
            instr_index[13]++;
          }

          if(subu_size!= std::string::npos){
            subu_array[instr_index[14]] = line;
            cout<<R_type_parse(instr_index[14],subu_array,subu_funct);
            subu_addr[instr_index[14]] = base+addr;   
            cout << " <= subu at address " <<subu_addr[instr_index[14]]<<"\n";       
            instr_index[14]++;
          }

          if(sltu_size!=std::string::npos){
            sltu_array[instr_index[15]] = line;
            cout<<R_type_parse(instr_index[15],sltu_array,sltu_funct);
            sltu_addr[instr_index[15]] = base+addr;   
            cout << " <= sltu at address " <<sltu_addr[instr_index[15]]<<"\n";       
            instr_index[15]++;
          }

          if(addu_size!=std::string::npos){
            addu_array[instr_index[16]] = line;
            cout<<R_type_parse(instr_index[16],addu_array,addu_funct);
            addu_addr[instr_index[16]] = base+addr;   
            cout << " <= addu at address " <<addu_addr[instr_index[16]]<<"\n";       
            instr_index[16]++;
          }

          if(or_size!=std::string::npos){
            if(line.at(0)=='n') // Removes incorrect recognition of 'or' within 'nor'
              continue; 
            or_array[instr_index[17]] = line;
            cout<<R_type_parse(instr_index[17],or_array,or_funct);
            or_addr[instr_index[17]] = base+addr;   
            cout << " <= or at address " <<or_addr[instr_index[17]]<<"\n";       
            instr_index[17]++;
          }

          if(and_size!=std::string::npos){
            and_array[instr_index[18]] = line;
            cout<<R_type_parse(instr_index[18],and_array,and_funct);
            and_addr[instr_index[18]] = base+addr;   
            cout << " <= and at address " <<and_addr[instr_index[18]]<<"\n";       
            instr_index[18]++;
          }

          if(ori_size!=std::string::npos){
            ori_array[instr_index[19]] = line;
            cout<<I_type_parse(instr_index[19],ori_array,ori_op);
            ori_addr[instr_index[19]] = base+addr;   
            cout << " <= ori at address " <<ori_addr[instr_index[19]]<<"\n";       
            instr_index[19]++;
          }

          if(sltiu_size!=std::string::npos){
            sltiu_array[instr_index[20]] = line;
            cout<<I_type_parse(instr_index[20],sltiu_array,sltiu_op);
            sltiu_addr[instr_index[20]] = base+addr;   
            cout << " <= sltiu at address " <<sltiu_addr[instr_index[20]]<<"\n";       
            instr_index[20]++;
          }

    
   }


           
    myfile.close();
  }





  return 0;
}

string I_type_parse(int i,string s[],string op){
string val1;
string val2;
string val12;
string val3;
string valx;
int bin0[4];
int bin1[4];
int bin2[4];
int bin3[4];

//first value
  int spos = s[i].find("$")+1;
   int epos = s[i].find(",");
  int length = (epos - spos);
  val1 = s[i].substr(spos, length);

//second value 
   spos = s[i].find_last_of("$")+1;
   epos = s[i].find_last_of(",");
   length = epos-spos;
   val2 = s[i].substr(spos, length);
  
   val12 = op+toBin_5(val2)+toBin_5(val1);
   
//imm value
   spos = s[i].find("x")+1;
   epos = s[i].size();
   length = epos-spos;
   val3 = s[i].substr(spos,length);
   if(op == "001111")
    val12 = op+"00000"+toBin_5(val1);
  
   


  valx = val12.substr(0, 4);
  for(int i = 0;i<4;i++)
    bin0[i] = valx.at(i) - '0';  

  valx = val12.substr(4, 8);
  for(int i = 0;i<4;i++)
    bin1[i] = valx.at(i) - '0'; 

  valx = val12.substr(8, 12);
  for(int i = 0;i<4;i++)
    bin2[i] = valx.at(i) - '0'; 

  valx = val12.substr(12, 16);
  for(int i = 0;i<4;i++)
    bin3[i] = valx.at(i) - '0'; 
  

    string hex_dig[32]={"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"};
    string hex0,hex1,hex2,hex3,hex_res;
    int idx0 = 8*bin0[0] + 4*bin0[1] + 2*bin0[2] + bin0[3];
    int idx1 = 8*bin1[0] + 4*bin1[1] + 2*bin1[2] + bin1[3];
    int idx2 = 8*bin2[0] + 4*bin2[1] + 2*bin2[2] + bin2[3];
    int idx3 = 8*bin3[0] + 4*bin3[1] + 2*bin3[2] + bin3[3];
    hex0 = hex_dig[idx0];
    hex1 = hex_dig[idx1];
    hex2 = hex_dig[idx2];
    hex3 = hex_dig[idx3];
    hex_res =  hex0+hex1+hex2+hex3+val3;

    return hex_res;
}




string R_type_parse(int i,string s[],string funct){
  // no support for shamt yet. only works for add
string special = "000000";
string val1;
string val2;
string val12;
string val3;
string valx;
int bin0[4];
int bin1[4];
int bin2[4];
int bin3[4];
int bin4[4];
int bin5[4];

//first value
  int spos = s[i].find("$")+1;
  int epos = s[i].find(",");
  int length = (epos - spos);
  val1 = s[i].substr(spos, length);

//second value 
   spos = s[i].find("$",epos)+1;
   epos = s[i].find(",",spos);
   length = epos-spos;
   val2 = s[i].substr(spos, length);
  //third value 
   spos = s[i].find_last_of("$")+1;
   epos = s[i].find_last_of(",");
   length = epos-spos;
   val3 = s[i].substr(spos, length);

   val12 = special+toBin_5(val2)+toBin_5(val3)+toBin_5(val1)+"00000";
   if((funct=="02") || (funct == "00")){
    spos = epos+1;
    val3 = s[i].substr(spos, s[i].size());
    val12 = special+"00000"+toBin_5(val2)+toBin_5(val1)+toBin_5(val3)+funct;
  }


 valx = val12.substr(0, 4);
  for(int i = 0;i<4;i++)
    bin0[i] = valx.at(i) - '0';  

  valx = val12.substr(4, 8);
  for(int i = 0;i<4;i++)
    bin1[i] = valx.at(i) - '0'; 

  valx = val12.substr(8, 12);
  for(int i = 0;i<4;i++)
    bin2[i] = valx.at(i) - '0'; 

  valx = val12.substr(12, 16);
  for(int i = 0;i<4;i++)
    bin3[i] = valx.at(i) - '0'; 

  valx = val12.substr(16, 20);
  for(int i = 0;i<4;i++)
    bin4[i] = valx.at(i) - '0'; 

  valx = val12.substr(20, 24);
  for(int i = 0;i<4;i++)
    bin5[i] = valx.at(i) - '0';
  


    string hex_dig[32]={"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"};
    string hex0,hex1,hex2,hex3,hex4,hex5;
    int idx0 = 8*bin0[0] + 4*bin0[1] + 2*bin0[2] + bin0[3];
    int idx1 = 8*bin1[0] + 4*bin1[1] + 2*bin1[2] + bin1[3];
    int idx2 = 8*bin2[0] + 4*bin2[1] + 2*bin2[2] + bin2[3];
    int idx3 = 8*bin3[0] + 4*bin3[1] + 2*bin3[2] + bin3[3];
    int idx4 = 8*bin4[0] + 4*bin4[1] + 2*bin4[2] + bin4[3];
    int idx5 = 8*bin5[0] + 4*bin5[1] + 2*bin5[2] + bin5[3];
    hex0 = hex_dig[idx0];
    hex1 = hex_dig[idx1];
    hex2 = hex_dig[idx2];
    hex3 = hex_dig[idx3];
    hex4 = hex_dig[idx4];
    hex5 = hex_dig[idx5];
    return hex0+hex1+hex2+hex3+hex4+hex5+funct;
}




string toBin_5(string y) {
  int a=1,sum=0,temp;
  string s;
  
  int x = atoi(y.c_str());
  temp = x;
while(x!=0){
  sum+=(x%2)*a;
  x=x/2;
  a=a*10;
  if(x==0) break;
}

if((temp>= 0) && (temp<= 1)){
  s = "0000"+to_string(sum);
}
else if ((temp>= 2) && (temp<= 3))
  s = "000"+to_string(sum);
else if ((temp>= 4) && (temp<= 7))
  s = "00"+to_string(sum);
else if ((temp>= 8) && (temp<= 15))
  s = "0"+to_string(sum);
else if ((temp>= 16) && (temp<= 31))
  s = to_string(sum);
return s;
}




