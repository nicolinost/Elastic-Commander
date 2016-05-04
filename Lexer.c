#include<stdio.h>


enum TokenType {
  HTTP_VERB, STRING_LITERAL, URL_ENDPOINT, API,
  L_CURL_BRACKET, R_CURLY_BRACKET, COLON, L_SQUARE_ARRAY, R_SQUARE_ARRAY, COMMA
};

struct Token{
  enum TokenType TYPE;
  char * VALUE;
};

void ToString(struct Token * token);
void LexRawLine(char *Ptr);
void LexIdentifier(char *Ptr);

int main() {

  enum TokenType type = COMMA;
  struct Token t;
  t.TYPE = type;
  t.VALUE = "POST /kmcloud_percolator/.percolator/_search { } ";
  ToString(&t);

  LexRawLine(t.VALUE);
  
}


void LexRawLine(char *Ptr){
  
  while(*Ptr != '\0'){

     switch(*Ptr){

     case '{':
       printf("IS L_CURLY_BRACKET\n");
       //Append new token with L_CURLY_BRACKET as type
       break;
     case '}':
       printf("IS R_CURLY_BRACKET\n");
     //Append new token with R_CURLY_BRACKET as type
       break;
     case '[':
       printf("IS L_SQUARE_BRACKET\n");
       //append new token with L_SQUARE_BRACKET as type
       break;
        case ']':
       printf("IS R_SQUARE_BRACKET\n");
       //append new token with R_SQUARE_BRACKET as type
       break;
     case ',':
       printf("IS COMMA\n");
       //append new token with COMMA as type
       break;
     case '\"':
       printf("IS STRING_LITERAL\n");
       //LexStringLiteral(*Ptr);
       break;
     case '/':
       if((*Ptr)+1 != '_'){
	 printf("IS ENDPOINT\n");
	 //LexUrlEndPoint(*Ptr);
       }else{
	 printf("IS API\n");
	 //LexUrlApi(*Ptr);
       }
       break;
     case '_':
       printf("IS UNDERSCORE\n");
       //LexUrlApi(*Ptr);
       break;
     case 'a': case 'b': case 'c': case 'd': case 'e': case 'f': case 'g':
     case 'h': case 'i': case 'j': case 'k': case 'l': case 'm': case 'n':
     case 'o': case 'p': case 'q': case 'r': case 's': case 't': case 'u':
     case 'v': case 'w': case 'x': case 'y': case 'z':
     case 'A': case 'B': case 'C': case 'D': case 'E': case 'F': case 'G':
     case 'H': case 'I': case 'J': case 'K': case 'L': case 'M': case 'N':
     case 'O': case 'P': case 'Q': case 'R': case 'S': case 'T': case 'U':
     case 'V': case 'W': case 'X': case 'Y': case 'Z':
      printf("IS IDENTIFIER\n");
      //LexIdentifier(*Ptr);
      break;
     case ':':
       printf("IS COLON\n");
       //append new token with TOKEN as type
       break;
      
    }
     *Ptr++;
  }
  
}

void LexIdentifier(char *Ptr){
  
  while(*Ptr!='\0'){
    if(*Ptr == ' '){
      return 
    }
  }
}


void ToString(struct Token * token){
  printf("Type : %d ; Value : %s\n",token->TYPE,token->VALUE);   
}
