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
void LexRawLine(char &Ptr);

int main() {

  enum TokenType type = COMMA;
  struct Token t;
  t.TYPE = type;
  t.VALUE = "TEST";
  ToString(&t);

  LexRawLine(&t.VALUE);
  
}


void LexRawLine(char &Ptr){
  
  while(Ptr != '\0'){
    printf("%c\n",Ptr);
    Ptr++;
  }
  
}



void ToString(struct Token * token){
  printf("Type : %d ; Value : %s\n",token->TYPE,token->VALUE);   
}
