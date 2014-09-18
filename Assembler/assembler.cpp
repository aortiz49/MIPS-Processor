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

string ori_array[100];
string sltiu_array[100];
string addi_array[100];
string slti_array[100];
string addiu_array[100];
string andi_array[100];
string add_array[100];
string slt_array[100];
string sub_array[100];



string toBin_5(string y);
void I_type_parse(int i,string s[],string op);
void R_type_parse(int i,string s[],string funct);
int main () {
#define base 400000
  string line;
 
  string ori = "ori ";
  string sltiu = "sltiu ";
  string addi = "addi ";
  string slti = "slti ";
  string addiu = "addiu ";
  string andi = "andi ";
  string add = "add ";
  string slt = "slt ";
  string sub = "sub ";


  string ori_op = "001101";
  string sltiu_op = "001011";
  string addi_op ="001000";
  string slti_op = "001010";
  string addiu_op = "001001";
  string andi_op = "001100";

  string add_funct = "20";
  string slt_funct = "2A";
  string sub_funct = "22";

  int ori_addr[100];
  int sltiu_addr[100];
  int addi_addr[100];
  int slti_addr[100];
  int addiu_addr[100];
  int andi_addr[100];
  int add_addr[100];
  int slt_addr[100];
  int sub_addr[100];

  
  int a1 = 0;
  int a2 = 0;
  int a3 = 0;
  int a4 = 0;
  int a5 = 0;
  int a6 = 0;
  int a7 = 0;
  int a8 = 0;
  int a9 = 0;
  
  size_t ori_size;
  size_t sltiu_size;
  size_t addi_size;
  size_t slti_size;
  size_t addiu_size;
  size_t andi_size;
  size_t add_size;
  size_t slt_size;
  size_t sub_size;
 

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

//cout<<base+addr<<endl;
        
          if(ori_size!=std::string::npos){
            ori_array[a1] = line;
            I_type_parse(a1,ori_array,ori_op);
            ori_addr[a1] = base+addr;   
            cout << " <= ori at address " <<ori_addr[a1]<<"\n";       
            a1++;
          }

          if(sltiu_size!=std::string::npos){
            sltiu_array[a2] = line;
            I_type_parse(a2,sltiu_array,sltiu_op);
            sltiu_addr[a2] = base+addr;   
            cout << " <= sltiu at address " <<sltiu_addr[a2]<<"\n";       
            a2++;
          }

          if(addi_size!=std::string::npos){
            addi_array[a3] = line;
            I_type_parse(a3,addi_array,addi_op);
            addi_addr[a3] = base+addr;   
            cout << " <= addi at address " <<addi_addr[a3]<<"\n";       
            a3++;
          }

          if(slti_size!=std::string::npos){
            slti_array[a4] = line;
            I_type_parse(a4,slti_array,slti_op);
            slti_addr[a4] = base+addr;   
            cout << " <= slti at address " <<slti_addr[a4]<<"\n";       
            a4++;
          }

          if(addiu_size!=std::string::npos){
            addiu_array[a5] = line;
            I_type_parse(a5,addiu_array,addiu_op);
            addiu_addr[a5] = base+addr;   
            cout << " <= addiu at address " <<addiu_addr[a5]<<"\n";       
            a5++;
          }

          if(andi_size!=std::string::npos){
            andi_array[a6] = line;
            I_type_parse(a6,andi_array,andi_op);
            andi_addr[a6] = base+addr;   
            cout << " <= andi at address " <<andi_addr[a6]<<"\n";       
            a6++;
          }

          if(add_size!=std::string::npos){
            add_array[a7] = line;
            R_type_parse(a7,add_array,add_funct);
            add_addr[a7] = base+addr;   
            cout << " <= add at address " <<add_addr[a6]<<"\n";       
            a7++;
          }

          if(slt_size!=std::string::npos){
            slt_array[a8] = line;
            R_type_parse(a8,slt_array,slt_funct);
            slt_addr[a8] = base+addr;   
            cout << " <= slt at address " <<slt_addr[a8]<<"\n";       
            a8++;
          }

          if(sub_size!=std::string::npos){
            sub_array[a9] = line;
            R_type_parse(a9,sub_array,sub_funct);
            sub_addr[a9] = base+addr;   
            cout << " <= sub at address " <<sub_addr[a9]<<"\n";       
            a9++;
          }

           
          
      
   }



           
    myfile.close();
  }





  return 0;
}

void I_type_parse(int i,string s[],string op){
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
    string hex0,hex1,hex2,hex3;
    int idx0 = 8*bin0[0] + 4*bin0[1] + 2*bin0[2] + bin0[3];
    int idx1 = 8*bin1[0] + 4*bin1[1] + 2*bin1[2] + bin1[3];
    int idx2 = 8*bin2[0] + 4*bin2[1] + 2*bin2[2] + bin2[3];
    int idx3 = 8*bin3[0] + 4*bin3[1] + 2*bin3[2] + bin3[3];
    hex0 = hex_dig[idx0];
    hex1 = hex_dig[idx1];
    hex2 = hex_dig[idx2];
    hex3 = hex_dig[idx3];
    cout << hex0<<hex1<<hex2<<hex3<<val3;
}




void R_type_parse(int i,string s[],string funct){
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
    cout << hex0+hex1+hex2+hex3+hex4<<hex5<<funct;
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




