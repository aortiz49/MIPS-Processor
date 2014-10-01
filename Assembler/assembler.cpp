//////////////////////////////////////
// TODO: go to bne label thing. 
// Fix bits in hex. Add instrs
//
/////////////////////////////////////




// reading a text file
#include <iostream>
#include <bitset> 
#include <fstream>
#include <string>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdint.h>
#include <unistd.h>
#include <sstream>
#include <iostream>
#include <vector>
using namespace std;

// GLOBAL ARRAY
//Arrays that hold the string containing that instructions
// i.e ori_array[0] = ori $1, $1, 0xfffe
// I sort all the lines by instruction and parse them
const int NUM_LINES = 100;
vector<string> MASTER(NUM_LINES);

vector<string> firsta(100);
string hex_dig[32]={"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"};

string label_array[NUM_LINES];
string ori_array[NUM_LINES];
string sltiu_array[NUM_LINES];
string addi_array[NUM_LINES];
string slti_array[NUM_LINES];
string addiu_array[NUM_LINES];
string andi_array[NUM_LINES];
string add_array[NUM_LINES];
string slt_array[NUM_LINES];
string sub_array[NUM_LINES];
string lui_array[NUM_LINES];
string nor_array[NUM_LINES];
string srl_array[NUM_LINES];
string sll_array[NUM_LINES];
string subu_array[NUM_LINES];
string sltu_array[NUM_LINES];
string addu_array[NUM_LINES];
string or_array[NUM_LINES];
string and_array[NUM_LINES];
string bne_array[NUM_LINES];
string sw_array[NUM_LINES];
string lw_array[NUM_LINES];
string meh[NUM_LINES];



//string MASTER_ADDR[NUM_LINES];

string final_bne[NUM_LINES];



string  TESTyou[NUM_LINES];
string  TEST_addr[NUM_LINES];

// Address location where instrcution was found
  int label_addr[NUM_LINES];
  int bne_addr[NUM_LINES];
  int addr;



int instr_index[32];    // Temp
int label_index = 0;    

string toBin_5(string y);
string toHex_16(string y);
string I_type_parse(int i,string s[],string op);
string R_type_parse(int i,string s[],string funct);
void my_itoa(int value, std::string& buf, int vase);
int main () {
  //freopen("output.txt","w",stdout);
#define base 400000
  string line;  //
  string line1;
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
  string bne = "bne ";
  string sw = "sw ";
  string lw = "lw ";



  string ori_op = "001101";
  string sltiu_op = "001011";
  string addi_op ="001000";
  string slti_op = "001010";
  string addiu_op = "001001";
  string andi_op = "001100";
  string lui_op = "001111";
  string bne_op = "000101";
  string sw_op  = "101011";
  string lw_op = "100011";


  string add_funct  = "100000";
  string slt_funct  = "101010";
  string sub_funct  = "100010";
  string nor_funct  = "100111";
  string srl_funct  = "000010";
  string sll_funct  = "000000";
  string subu_funct = "100011";
  string sltu_funct = "101011";
  string addu_funct = "100001";
  string or_funct   = "100101";
  string and_funct  = "100100";





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
  size_t bne_size;
  size_t sw_size;
  size_t lw_size;
  int count=0;
 

// Grab all instructions and labels
  ifstream myfile ("test.txt");
  while (myfile.is_open()){

    while(!myfile.eof())
    {
        getline(myfile,line);
        if(line.find(":")!=string::npos){
    count--;
  } 
        count++;
}


myfile.clear();
myfile.seekg (0, ios::beg);


for(addr = 0;!myfile.eof();addr++){

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
        bne_size = line.find(bne);
        sw_size = line.find(sw);
        lw_size = line.find(lw);
       

         

          if(addi_size!=std::string::npos){
            addi_array[instr_index[3]] = line;
            MASTER[addr] = I_type_parse(instr_index[3],addi_array,addi_op); 
            instr_index[3]++;
          }


          if(slti_size!=std::string::npos){
            slti_array[instr_index[4]] = line;
            MASTER[addr] = I_type_parse(instr_index[4],slti_array,slti_op);        
            instr_index[4]++;
          }

          if(addiu_size!=std::string::npos){
            addiu_array[instr_index[5]] = line; 
            MASTER[addr] = I_type_parse(instr_index[5],addiu_array,addiu_op);      
            instr_index[5]++;
          }

          if(andi_size!=std::string::npos){
            andi_array[instr_index[6]] = line;  
            MASTER[addr] = I_type_parse(instr_index[6],andi_array,andi_op);
            instr_index[6]++;
          }

          if(add_size!=std::string::npos){
            add_array[instr_index[7]] = line;  
            MASTER[addr] = R_type_parse(instr_index[7],add_array,add_funct);       
            instr_index[7]++;
          }

          if(slt_size!=std::string::npos){
            slt_array[instr_index[8]] = line;
            MASTER[addr] = R_type_parse(instr_index[8],slt_array,slt_funct);    
            instr_index[8]++;
          }

          if(sub_size!=std::string::npos){
            sub_array[instr_index[9]] = line;
            MASTER[addr] = R_type_parse(instr_index[9],sub_array,sub_funct);       
            instr_index[9]++;
          }

          if(lui_size!=std::string::npos){
            lui_array[instr_index[10]] = line;  
            MASTER[addr] = I_type_parse(instr_index[10],lui_array,lui_op);
            instr_index[10]++;
          }

          if(nor_size!=std::string::npos){
            nor_array[instr_index[11]] = line;  
            MASTER[addr] =R_type_parse(instr_index[11],nor_array,nor_funct);      
            instr_index[11]++;
          }

          if(srl_size!=std::string::npos){
            srl_array[instr_index[12]] = line; 
            MASTER[addr] = R_type_parse(instr_index[12],srl_array,srl_funct);     
            instr_index[12]++;
          }

          if(sll_size!=std::string::npos){
            sll_array[instr_index[13]] = line;
           MASTER[addr] = R_type_parse(instr_index[13],sll_array,sll_funct);      
            instr_index[13]++;
          }

          if(subu_size!= std::string::npos){
            subu_array[instr_index[14]] = line;
            MASTER[addr] = R_type_parse(instr_index[14],subu_array,subu_funct);      
            instr_index[14]++;
          }

          if(sltu_size!=std::string::npos){
            sltu_array[instr_index[15]] = line;
            MASTER[addr] = R_type_parse(instr_index[15],sltu_array,sltu_funct);      
            instr_index[15]++;
          }

          if(addu_size!=std::string::npos){
            addu_array[instr_index[16]] = line;
            MASTER[addr] = R_type_parse(instr_index[16],addu_array,addu_funct);     
            instr_index[16]++;
          }

          if(or_size!=std::string::npos){
            if(line.at(0)=='n') // Removes incorrect recognition of 'or' within 'nor'
              continue; 
            or_array[instr_index[17]] = line;
            MASTER[addr] = R_type_parse(instr_index[17],or_array,or_funct);    
            instr_index[17]++;
          }

          if(and_size!=std::string::npos){
            and_array[instr_index[18]] = line;
           MASTER[addr] = R_type_parse(instr_index[18],and_array,and_funct);      
            instr_index[18]++;
          }

          if(ori_size!=std::string::npos){
            ori_array[instr_index[19]] = line;
            MASTER[addr] =  I_type_parse(instr_index[19],ori_array,ori_op);      
            instr_index[19]++;
          }

          if(sltiu_size!=std::string::npos){
            sltiu_array[instr_index[20]] = line;
            MASTER[addr] =  I_type_parse(instr_index[20],sltiu_array,sltiu_op);
           instr_index[20]++;
          }
 
          if(bne_size!=std::string::npos){
            string temp_label[100];                                                       // Contains all label strings within bne
            int white_spc=0;
            int spos = 0;
            int epos = 0;
            bne_addr[instr_index[21]] = base+addr;                                        // address where bne is at
            bne_array[instr_index[21]] = line;  

            final_bne[instr_index[21]]= I_type_parse(instr_index[21],bne_array,bne_op); 
            spos = bne_array[instr_index[21]].find_last_of(",")+1;                        // start location to grab label         
            epos = bne_array[instr_index[21]].size();                                                                     // check for whitespace in label
            white_spc = bne_array[instr_index[21]].find_first_not_of(" ",spos);           // white_spc = index of 1st non-white space char
           
            temp_label[instr_index[21]] = bne_array[instr_index[21]].substr(white_spc,epos);
            TESTyou[instr_index[21]] = temp_label[instr_index[21]];
            
            MASTER[addr] =  TESTyou[instr_index[21]];
            //cout<<TESTyou[instr_index[21]]<<endl;
           // cout << " <= bne at address " <<bne_addr[instr_index[21]]<<"\n";       
            instr_index[21]++;

          }

          if(label_size!=std::string::npos){
            addr--;
            label_addr[label_index] = base+addr;                    // We don't want to include label addrs in local addrs. Messes up displacement calculation
            label_array[label_index] = line.substr(0,label_size);        
            //MASTER[addr] = .clear();
             label_index++;
          }         



          if(sw_size!=std::string::npos){
            sw_array[instr_index[22]] = line;    
            MASTER[addr] = I_type_parse(instr_index[22],sw_array,sw_op);
            instr_index[22]++;
          }

          if(lw_size!=std::string::npos){
            lw_array[instr_index[23]] = line;    
            MASTER[addr] = I_type_parse(instr_index[22],lw_array,lw_op);
            instr_index[23]++;
          }


}  

myfile.clear();
myfile.seekg (0, ios::beg);

//// bne logic"
  int bne_BTA[label_index];
  int bta_master[label_index];
  int bne_BTA_index=0;
  string a[100];
  string bne_BTA_array[100];
  char result[1];                                       // Using as buffer 
  for( int j = 0; j<label_index; j++){     
                  // Number of bne instructions
    for( int i = 0; i<label_index ; i++){   

        if( TESTyou[j] == label_array[i]){
            //cout <<"bne label ["<<TESTyou[j]<<"] at address "<<bne_addr[j]<<" matches label "<<label_array[i]<<" at address "<< label_addr[i]<<endl;  
           
            bne_BTA[bne_BTA_index] = (label_addr[i])-(bne_addr[j]);
            if(bne_BTA[bne_BTA_index] > 0)
              bne_BTA[bne_BTA_index] = (label_addr[i])-(bne_addr[j]);
            else if(bne_BTA[bne_BTA_index] < 0)
              bne_BTA[bne_BTA_index] = (label_addr[i]+1)-(bne_addr[j]);

            if(bne_BTA[bne_BTA_index] > 65535)
              exit (EXIT_FAILURE);
            else if(bne_BTA[bne_BTA_index] < 0)
              bne_BTA[bne_BTA_index]+= 65535;
          
          sprintf( result, "%04x", bne_BTA[bne_BTA_index] );
         // cout<<"We will now displace addr reg by "<<bne_BTA[bne_BTA_index]<<endl;           
          bne_BTA_array[bne_BTA_index] = result;
           a[bne_BTA_index] = final_bne[bne_BTA_index]+bne_BTA_array[bne_BTA_index];
          // cout<<a[bne_BTA_index]<<"\n";
          bne_BTA_index++;    

        }
    }
}

                                       // Using as buffer 
  for( int j = 0; j<label_index; j++){                        // Number of bne instructions
    for( int i = 0; i<count-label_index ; i++){   
        if( TESTyou[j] == MASTER[i]){
           //cout <<"bne label ["<<TESTyou[j]<<"] at address "<<" matches label "<<MASTER[i]<<endl;
         //  cout<<i<<endl;
           // MASTER[i] = final_bne[bne_BTA_index]+bne_BTA_array[bne_BTA_index];
            //cout<<final_bne[bne_BTA_index]<<endl;
         // MASTER[i] = "sadjfg\n";
         
          MASTER[i] = a[j];     
        }
    }
}



for(int i = 0; i<count;i++){
  getline(myfile,line);
  
 cout<<"    "<<i<<": "<<MASTER.at(i)<<"\n";
}

cout<<MASTER[0]<<"\n";
string ss;
my_itoa(4095,ss,2);
cout<<ss<<"\n";

    myfile.close();
}
//test foor loop
cout<<"WIDTH=32;\nDEPTH=256;\n \nADDRESS_RADIX=HEX; \nDATA_RADIX=HEX;\n\nCONTENT BEGIN\n";



  return 0;
}

string I_type_parse(int i,string s[],string op){
string val1;
string val2;
string val12;
string val3;
string valx;
string temp_label[NUM_LINES];
int bin0[4];
int bin1[4];
int bin2[4];
int bin3[4];
int temp_bin[4];

int j,k = 0;

int white_spc;

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
   spos = s[i].find("x")+1;                                 // not assigned is bne
   epos = s[i].size();
   length = epos-spos;
   val3 = s[i].substr(spos,length);

    if(op == "001111")                                      // LUI support
        val12 = op+"00000"+toBin_5(val1);

   else if (op == "000101"){                                // fetch bne label
    val12 = op + toBin_5(val1) + toBin_5(val2);  
    val3.clear();
 }

  else if (op == "101011"){
    val12 = op + toBin_5(val2)+toBin_5(val1);
    spos = s[i].find_last_of(",")+1;
    spos  = s[i].find_first_not_of(" ",spos);
    epos = s[i].find("(");
    length = epos-spos;
      val3 = s[i].substr(spos,length);
      
      if(val3.find("x")!=string::npos){
        spos = val3.find("x")+1;
        epos = val3.find("(");
      length = epos-spos;
        val3 = val3.substr(spos,length);
    }

    else{
      val3 = toBin_5(val3);
      //toHex_16(val12) 
    }
}



  else if(op == "100011"){

  }

 string hex_res = toHex_16(val12)+val3;
    
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
int bin6[4];
int bin7[4];

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


   val12 = special+toBin_5(val2)+toBin_5(val3)+toBin_5(val1)+"00000"+funct;
   if((funct=="000010") || (funct == "000000")){
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

   valx = val12.substr(24, 28);
  for(int i = 0;i<4;i++)
    bin6[i] = valx.at(i) - '0';

  valx = val12.substr(28, 32);
  for(int i = 0;i<4;i++)
    bin7[i] = valx.at(i) - '0';



  


    string hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;
    int idx0 = 8*bin0[0] + 4*bin0[1] + 2*bin0[2] + bin0[3];
    int idx1 = 8*bin1[0] + 4*bin1[1] + 2*bin1[2] + bin1[3];
    int idx2 = 8*bin2[0] + 4*bin2[1] + 2*bin2[2] + bin2[3];
    int idx3 = 8*bin3[0] + 4*bin3[1] + 2*bin3[2] + bin3[3];
    int idx4 = 8*bin4[0] + 4*bin4[1] + 2*bin4[2] + bin4[3];
    int idx5 = 8*bin5[0] + 4*bin5[1] + 2*bin5[2] + bin5[3];
    int idx6 = 8*bin6[0] + 4*bin6[1] + 2*bin6[2] + bin6[3];
    int idx7 = 8*bin7[0] + 4*bin7[1] + 2*bin7[2] + bin7[3];
    hex0 = hex_dig[idx0];
    hex1 = hex_dig[idx1];
    hex2 = hex_dig[idx2];
    hex3 = hex_dig[idx3];
    hex4 = hex_dig[idx4];
    hex5 = hex_dig[idx5];
    hex6 = hex_dig[idx6];
    hex7 = hex_dig[idx7];
    return hex0+hex1+hex2+hex3+hex4+hex5+hex6+hex7;
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

string toHex_16(string y){
int bin0[4];
int bin1[4];
int bin2[4];
int bin3[4];
string valx;
   valx = y.substr(0, 4);
  for(int i = 0;i<4;i++)
    bin0[i] = valx.at(i) - '0';  

  valx = y.substr(4, 8);
  for(int i = 0;i<4;i++)
    bin1[i] = valx.at(i) - '0'; 

  valx = y.substr(8, 12);
  for(int i = 0;i<4;i++)
    bin2[i] = valx.at(i) - '0'; 

  valx = y.substr(12, 16);
  for(int i = 0;i<4;i++)
    bin3[i] = valx.at(i) - '0'; 
    
    string hex0,hex1,hex2,hex3,hex_res;
    int idx0 = 8*bin0[0] + 4*bin0[1] + 2*bin0[2] + bin0[3];
    int idx1 = 8*bin1[0] + 4*bin1[1] + 2*bin1[2] + bin1[3];
    int idx2 = 8*bin2[0] + 4*bin2[1] + 2*bin2[2] + bin2[3];
    int idx3 = 8*bin3[0] + 4*bin3[1] + 2*bin3[2] + bin3[3];
    hex0 = hex_dig[idx0];
    hex1 = hex_dig[idx1];
    hex2 = hex_dig[idx2];
    hex3 = hex_dig[idx3];
    return hex0+hex1+hex2+hex3;

}

void my_itoa(int value, std::string& buf, int vase){
  
  int i = 30;
  
  buf = "";
  
  for(; value && i ; --i, value /= vase) buf = "0123456789abcdef"[value % vase] + buf;
  
}

