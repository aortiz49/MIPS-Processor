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
string slt_array[100]; 
string lui_array[100];

string toBin_5(string y);
void ORI_parse(int i);

int main () {
#define base 400000
  string line;
  string slt = "slt ";
  string ori = "ori ";
  string lui = "lui ";

  int slt_addr[100];
  int ori_addr[100];
  int lui_addr[100];
  int i=0;
  int j = 0;
  size_t slt_size;
  size_t ori_size;
  size_t lui_size;
  string opcodes [32][2];



  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";
  opcodes [0][0] = "ori"; opcodes [0][1] = "001100";



// Grab all instructions and labels
  ifstream myfile ("test.txt");
  while (myfile.is_open()){  
/*
for(int i = 1; !myfile.eof(); i++){
        getline (myfile,line);
        found1 = line.find(slt );
        if (found1!=std::string::npos){
            token[i] = line.substr(0, line.find(slt ));
            cout << token[i] << "\n";
          }

   } 
   */
// clear EOF flag, go to begining of file 
//myfile.clear();
//myfile.seekg(0, ios::beg);

for(int addr = 1;!myfile.eof();addr++){
        getline (myfile,line);
        ori_size = line.find(ori);
        slt_size = line.find(slt);
        lui_size = line.find(lui);

         if(ori_size!=std::string::npos){
            ori_array[i] = line;
            ORI_parse(i);
            ori_addr[i] = base+addr;   
            cout << " <= address " <<ori_addr[i]<<"\n";       
            i++;
          }
          
        else if (slt_size!=std::string::npos){
            slt_array[j] = line;
            slt_addr[j] = base+addr;
           j++;
          }

            else if (lui_size!=std::string::npos){
            lui_array[i] = line.substr(0, line.find(lui ));
            lui_addr[i] = base+i;
          }

   }

  
/*
   for (int i = 0; i < 30; ++i)
   {
     cout <<ori_array[i]<<"\n";
   }

*/
           
    myfile.close();
  }
////////////////// LUI


  return 0;
}

void ORI_parse(int i){
string ori_op = "001101";
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
  int spos = ori_array[i].find("$")+1;
  int epos = ori_array[i].find(",");
  int length = (epos - spos);
  val1 = ori_array[i].substr(spos, length);

//second value 
   spos = ori_array[i].find_last_of("$")+1;
   epos = ori_array[i].find_last_of(",");
   length = epos-spos;
   val2 = ori_array[i].substr(spos, length);
  
   val12 = ori_op+toBin_5(val2)+toBin_5(val1);
   
//imm value
   spos = ori_array[i].find("x")+1;
   epos = ori_array[i].size();
   length = epos-spos;
   val3 = ori_array[i].substr(spos,length);
   


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
    cout << hex0+hex1+hex2+hex3+val3;
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





