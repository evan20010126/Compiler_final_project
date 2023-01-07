%{
    #include <stdio.h>
    #include <string.h> 
    #include <math.h>
    char function_map[30][200] = {0}; // copy:   strcpy(function_map["變數"-'A'], str)
    int x = 2e9, y = 2e9, z = 2e9;  //(x==2e9)?not define : x 

    int re[3][200];
    int constant = 0;
    char return_string[1000];
    
    // flag[0] = 1
    //     [1] = 0
    //     [2] = 1
    //     [3] = 0
    //     [4] = 1
    // //strcspn strpbrk
    // x=1
    // F = y^2
    // G = x^2 + y 
    // H = 1
    
    // function_map[0]="x^2+1"  A
    //             [1]=""       B
    //             [2]="y^2+1"  C
    //             [3]=""       D
    //             [4]="z^2+1"` 
    void string_to_array(char *function_map){
        int fun_size = strlen(function_map);
        int i ,j, k;
        int val = 0;
        int bo = 1;
        for(i=0;i<3;i++){
            for(j=0;j<200;j++){
                re[i][j]=0;
            }
        }
        for(i=1;i<fun_size-1;i++){
            if(function_map[i]=='x'||function_map[i]=='y'||function_map[i]=='z'){
                if(function_map[i]=='x')k=0;
                if(function_map[i]=='y')k=1;
                if(function_map[i]=='z')k=2;
                i++;
                int now=0;
                for(j=1;function_map[i+j]>='0'&&function_map[i+j]<='9';i++){
                    now=now*10;
                    now+=(function_map[i+j]-'0');
                }
                if(val == 0 )val = 1;
                //printf("val:%d \n",val);
                re[k][now]+=val*bo;
                //printf("now:%d \n",now);
                val = 0;
                bo = 1;
                i=i+j-1;
            }
            else if(function_map[i]=='-'){
                bo = -1;
            }
            else if(function_map[i]>='0'&&function_map[i]<='9'){
                for(j=0;function_map[i+j]>='0'&&function_map[i+j]<='9';j++){
                    val=val*10;
                    val+=(function_map[i+j]-'0');
                }
                i=i+j-1;
            }
        }
        constant = val*bo;
    }

    void itoa (int n, char s[])
    {
        int i,j,sign;
        if((sign=n)<0)//記錄符號
            n=-n;//使n成為正數
        i=0;
        do{
            s[i++]=n%10+'0';//取下一個數字
        }while ((n/=10)>0);//刪除該數字
        
        if(sign<0)
            s[i++]='-';
        s[i]='\0';
        s = strrev(s);
    }

    char* compute_and_combine(char* str1,char* str2, char op){
        string_to_array(str1);
        int constant_new = constant;

        int temp[3][200] = {0};

        int i = 0;
        int j = 0;
        for(i=0;i<3;i++){
            for(j=0;j<200;j++){
                temp[i][j] = re[i][j];
            }
        }
        string_to_array(str2);
        if (op == '+'){
            for(i=0;i<3;i++){
                for(j=0;j<200;j++){
                    temp[i][j] += re[i][j];
                }
            }
            constant_new += constant;
        }else if(op == '-'){
            for(i=0;i<3;i++){
                for(j=0;j<200;j++){
                    temp[i][j] -= re[i][j];
                }
            }
            constant_new -= constant;
        }
        char output[1000] = "";
        for(i=199;i>=0;i--){
            for(j=0;j<3;j++){
                if(temp[j][i] == 0) continue;
                // printf("%d %d\n", i,j);
                
                char powerNumber[1000];
                itoa(abs(i), powerNumber);
                char cofNumber[10000];
                itoa(abs(temp[j][i]), cofNumber);
                if(j == 0){
                    if(temp[j][i] == -1){
                        strcat(output, "-x^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] == 1 ){
                        strcat(output, "+x^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] < -1){
                        strcat(output, "-");
                        strcat(output, cofNumber);
                        strcat(output, "x^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] > 1){
                        strcat(output, "+");
                        strcat(output, cofNumber);
                        strcat(output, "x^");
                        strcat(output, powerNumber);
                    }
                }else if(j == 1){
                    if(temp[j][i] == -1){
                        strcat(output, "-y^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] == 1 ){
                        strcat(output, "+");
                        strcat(output, "y^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] < -1){
                        strcat(output, "-");
                        strcat(output, cofNumber);
                        strcat(output, "y^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] > 1){
                        strcat(output, "+");
                        strcat(output, cofNumber);
                        strcat(output, "y^");
                        strcat(output, powerNumber);
                    }
                }else if(j == 2){
                    if(temp[j][i] == -1){
                        strcat(output, "-z^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] == 1 ){
                        strcat(output, "+");
                        strcat(output, "z^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] < -1){
                        strcat(output, "-");
                        strcat(output, cofNumber);
                        strcat(output, "z^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] > 1){
                        strcat(output, "+");
                        strcat(output, cofNumber);
                        strcat(output, "z^");
                        strcat(output, powerNumber);
                    }
                }
            }
        }
        char constNumber[1000];
        itoa(constant_new, constNumber);
        if(constant_new > 0){
            strcat(output, "+");
            strcat(output, constNumber);
        }
        if(constant_new < 0){
            strcat(output, constNumber);
        }
        if(output[0] == '+'){
            strcpy(output, &output[1]);
        }
        char new_output[1000] = "{";
        char tail[2] = "}";
        strcat(new_output, output);
        strcat(new_output, tail);
        // printf("new_output: %s\n", new_output);
        return new_output;
    }
    
    void get_number(){
        int i,j,k;
        int m,n;
        int val = constant;
        char str[1000]="{";
        char now[1000]="";
        for(i=199;i>0;i--){
            //printf("i: %d\n",i);
            for(j=0;j<3;j++){
                //printf("i:%d j:%d \n",i,j);
                if(re[j][i]!=0){
                    if(j==0)k=x;
                    if(j==1)k=y;
                    if(j==2)k=z;
                    if(k==2e9){
                        if(re[j][i]==-1){
                            strcat(str,"-");
                        }
                        else if(re[j][i]<0){
                            now[0]='\0';
                            itoa(re[j][i],now);
                            strcat(str,now);
                        }
                        else if(re[j][i]!=1){
                            if(str[1]!='\0')strcat(str,"+");
                            printf("");
                            now[0]='\0';
                            itoa(re[j][i],now);
                            strcat(str,now);
                        }
                        else{
                            if(str[1]!='\0')strcat(str,"+");
                        }
                        if(j==0)strcat(str,"x^");
                        if(j==1)strcat(str,"y^");
                        if(j==2)strcat(str,"z^");
                        strcpy(now,"");
                        itoa(i,now);
                        strcat(str,now);
                    }
                    else{
                        n=1;
                        for(m=0;m<i;m++){
                            n=n*k;
                        }
                        //printf("n:%d\n",n);
                        //printf("pre_val:%d\n",val);
                        val = val +(re[j][i] * n);
                        //printf("re[j][i]:%d\n",re[j][i]);
                        //printf("val:%d\n",val);
                    }
                }
            }
        }
        strcpy(now,"");
        itoa(val,now);
        if(str[1]=='\0'){
            strcpy(str,now);
        }
        else if(val<0){
            //strcat(str,"-");
            strcat(str,now);
            strcat(str,"}");
        }
        else if(val!=0){
            strcat(str,"+");
            strcat(str,now);
            strcat(str,"}");
        }
        else {
            strcat(str,"}");
        }
        strcpy(return_string,str);
    }

    char* derive_function(char var){
        int i = 0;
        int j;
        int k;
        if(var == 'x')k=0;
        if(var == 'y')k=1;
        if(var == 'z')k=2;
         
        int temp[3][200] = {0};
        for(i=0;i<200;i++){
            for(j=0;j<3;j++){
                if(j!=k){
                    temp[j][i]=re[j][i];     
                }
                else if( j==k && (i != 199)){
                    temp[j][i] = re[j][i+1] * (i+1);  
                }      
            }
        }
        constant = 0;
        int ind = 0;
        for(ind = 0;ind < 3;ind++){
            constant += temp[ind][0];
        }
        //------------------------------------------------
        char output[1000] = "";
        for(i=199;i>0;i--){
            for(j=0;j<3;j++){
                if(temp[j][i] == 0) continue;
                // printf("%d %d\n", i,j);
                
                char powerNumber[1000];
                itoa(abs(i), powerNumber);
                char cofNumber[10000];
                itoa(abs(temp[j][i]), cofNumber);
                if(j == 0){
                    if(temp[j][i] == -1){
                        strcat(output, "-x^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] == 1 ){
                        strcat(output, "+x^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] < -1){
                        strcat(output, "-");
                        strcat(output, cofNumber);
                        strcat(output, "x^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] > 1){
                        strcat(output, "+");
                        strcat(output, cofNumber);
                        strcat(output, "x^");
                        strcat(output, powerNumber);
                    }
                }else if(j == 1){
                    if(temp[j][i] == -1){
                        strcat(output, "-y^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] == 1 ){
                        strcat(output, "+");
                        strcat(output, "y^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] < -1){
                        strcat(output, "-");
                        strcat(output, cofNumber);
                        strcat(output, "y^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] > 1){
                        strcat(output, "+");
                        strcat(output, cofNumber);
                        strcat(output, "y^");
                        strcat(output, powerNumber);
                    }
                }else if(j == 2){
                    if(temp[j][i] == -1){
                        strcat(output, "-z^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] == 1 ){
                        strcat(output, "+");
                        strcat(output, "z^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] < -1){
                        strcat(output, "-");
                        strcat(output, cofNumber);
                        strcat(output, "z^");
                        strcat(output, powerNumber);
                    }
                    else if(temp[j][i] > 1){
                        strcat(output, "+");
                        strcat(output, cofNumber);
                        strcat(output, "z^");
                        strcat(output, powerNumber);
                    }
                }
            }
        }
        char constNumber[1000];
        
        itoa(constant, constNumber);
        if(constant > 0){
            strcat(output, "+");
            strcat(output, constNumber);
        }
        if(constant < 0){
            strcat(output, constNumber);
        }
        if(output[0] == '+'){
            strcpy(output, &output[1]);
        }
        char new_output[1000] = "{";
        char tail[2] = "}";
        strcat(new_output, output);
        strcat(new_output, tail);
        // printf("new_output: %s\n", new_output);
        return new_output;
    }
%}



%union{
    int intval;
    char *strval;
}

%token NUMBER
%token ADD SUB ASSIGN DERIVE
%token EOL
%token FUNCTION  
%token FUNCTIONNAME VAR 

%type<strval> FUNCTION
%type<intval> NUMBER
%type<strval> FUNCTIONNAME
%type<strval> VAR

%type<strval> exp
%type<strval> command
%type<strval> term
%%
commandlist:
|commandlist command EOL

command: 
| FUNCTIONNAME ASSIGN exp {
    strcpy(function_map[(int)($1[0]-'A')],$3); 
} // F = ...

| VAR ASSIGN NUMBER {
    if($1[0] == 'x'){
        x = $3;
    }
    else if($1[0] == 'y'){
        y = $3;
    }
    else if($1[0] == 'z'){
        z = $3;
    }
    else{
        printf("error\n");
    }
    int i;
    for(i=0;i<26;i++){
        if(strlen(function_map[i]) != 0){
            printf("origin %c: %s\n", i+'A',function_map[i]);
            string_to_array(function_map[i]);
            get_number();
            printf("answer %c: %s \n\n",i+'A',return_string);
        }
    }
    printf("-------------------\n");
    if(x==2e9){
        printf("|x: | undefined   |\n");
    }

    if(x!=2e9){
        printf("|x: |%7d      |\n", x);
    }
    printf("-------------------\n");
    if(y == 2e9){
        printf("|y: | undefined   |\n");
    }

    if(y!=2e9){
        printf("|y: |%7d      |\n", y);
    }
    printf("-------------------\n");
    if(z == 2e9){
        printf("|z: | undefined   |\n");
    }

    if(z!=2e9){
        printf("|z: |%7d      |\n", z);
    }
    printf("-------------------\n");
}



exp: term 
|exp ADD term{
    // printf("%s + %s =", $1 , $3) ;
    $$ = compute_and_combine($1, $3, '+');
    // printf("output: %s\n", $$);
}

|exp SUB term   {
    // printf("%s + %s =", $1 , $3) ;
    $$ = compute_and_combine($1, $3, '-');
    // printf("output: %s\n", $$);
}

|exp ADD term   {/*$$=$1+function_map[$3];*/
    if(strlen(function_map[(int)($3[0]-'A')])==0){
        printf("%s is undefined\n", $3);
    }
    else{
        $$ = compute_and_combine($1, function_map[(int)($3[0]-'A')], '+');       
    }
}
|exp SUB term   {/*$$=$1-function_map[$3];*/
    if(strlen(function_map[(int)($3[0]-'A')])==0){
        printf("%s is undefined\n", $3);
    }
    else{
        $$ = compute_and_combine($1, function_map[(int)($3[0]-'A')], '-');       
    }
}


term: term DERIVE VAR {
    string_to_array($1);
    $$ = derive_function($3[0]);
}
|FUNCTION{strcpy($$,$1);}
|FUNCTIONNAME{
    if(strlen(function_map[(int)($1[0]-'A')])==0){
        printf("%s is undefined\n", $1);
    }else{
        $$ = function_map[(int)($1[0]-'A')];
    }
}

%%

main(int argc,char **argv){
yyparse();
}

yyerror(char *s)
{
fprintf(stderr,"error:%s\n",s);
}

