#include <AFMotor.h>

AF_DCMotor motorLeft(1);
AF_DCMotor motorRight(4);

void setup() {
  Serial.begin(9600);
  setVelocidade(0);
}


char cha;
void loop() {
 
  if (Serial.available() > 0) {
    cha = Serial.read();
    delay(2);
    Serial.println( cha);
    switch (cha) {
      case 'F':
        frente();
        break;
      case 'T':
        atras();
        break;
      case 'E':
        esquerda();
        break;
      case 'D':
        direita();
        break;
      case 'P':
        para();
        break;
    }
    delay(200);
    para();
  }
}

void frente() {
  setVelocidade(255);
  motorLeft.run(FORWARD);
  motorRight.run(FORWARD);
}

void atras() {
  setVelocidade(255);
  motorLeft.run(BACKWARD);
  motorRight.run(BACKWARD);
}

void esquerda() {
  setVelocidade(255);
  motorRight.run(FORWARD);
}

void direita() {
  setVelocidade(255);
  motorLeft.run(FORWARD);
}

void para() {
  setVelocidade(0);
  motorLeft.run(RELEASE);
  motorRight.run(RELEASE);
}

void setVelocidade (int v) {
    motorLeft.setSpeed(v);
    motorRight.setSpeed(v);
}