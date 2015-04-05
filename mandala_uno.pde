/**
 * PI is wrong
 * http://tauday.com/tau-manifesto
 */
static float TAU = TWO_PI;

boolean sketchFullScreen() {
  return true;
}

void setup() {
  size(displayWidth, displayHeight);
  // size(501, 501);
  noLoop();
}

void draw() {
  noStroke();
  fill(0);
  rect(0, 0, width, height);

  /**
   * Líneas que cruzan el centro de la pantalla
   */  
  // stroke(0, 255, 0);
  // line(0, height/2, width, height/2);
  // line(width/2, 0, width/2, height);
  
  pushMatrix();
  translate(width/2, height/2);

  /** 
   * Color que recibe todo a partir de YA! 
   */
  stroke(210);


  /** 
   * Círculo externo
   */
  noFill();
  // stroke(150, 50, 200);
  float rO = 500;
  ellipse(0, 0, rO, rO);
  
  /** 
   * Círculo interno
   */
  noFill();
  // stroke(0, 255, 0);
  float rI = rO - 40;
  ellipse(0, 0, rI, rI);

  /**
   * Puntos para el círculo externo
   */
  PVector outerPoints[] = new PVector[30];
  float angle = TAU / outerPoints.length;
  float theta = TAU;
  for(int i = 0; i < outerPoints.length; i++) {
    float x = sin(theta) * rO / 2;
    float y = cos(theta) * rO / 2;
    outerPoints[i] = new PVector(x, y);
    // fill(255);
    // noStroke();
    // ellipse(x, y, 5, 5); //círculo para marcar los puntos
    theta += angle;
  }


  /**
   * Puntos para el círculo interno
   */
  PVector innerPoints[] = new PVector[60];
  angle = TAU / innerPoints.length;
  theta = TAU + (angle / 2);
  for(int i = 0; i < innerPoints.length; i++) {
    float x = sin(theta) * rI / 2;
    float y = cos(theta) * rI / 2;
    innerPoints[i] = new PVector(x, y);
    // fill(255,0,0);
    // noStroke();
    // ellipse(x, y, 5, 5); //círculo para marcar los puntos
    theta += angle;
  }

  /**
   * Descomentar si se dibujanl los puntos en los
   * círculos externos
   */
  // noFill();
  // stroke(210);

  /** 
   * Las liñítas entre los círculos
   */
  for(int i = 0; i < innerPoints.length; i+=2) {
    // stroke(255);    
    line(innerPoints[i].x, innerPoints[i].y, outerPoints[i/2].x, outerPoints[i/2].y);
  }

  for(int i = 1; i < innerPoints.length; i+=2) {
    // stroke(255);
    if((i+1) / 2 < outerPoints.length)
      line(innerPoints[i].x, innerPoints[i].y, outerPoints[(i+1)/2].x, outerPoints[(i+1)/2].y);    
  }
  line(innerPoints[innerPoints.length - 1].x, innerPoints[innerPoints.length - 1].y, outerPoints[0].x, outerPoints[0].y);

  /**
   * Los óvalos del medio
   */
  angle = TAU / 16;
  theta = TAU;
  float r3 = rO / 2;
  pushMatrix();
  for(int i = 0; i < 16; i+=2) {
    rotate(theta);
    ellipse(0, 0, r3 / 2, (r3 / 2) - (16 * rO / 100));
    theta += angle;
  }
  popMatrix();

  /** 
   * Los hexágonos del medio
   */
  pushMatrix();
  float outerAngle = TAU / 7;
  float outerTheta = TAU - outerAngle * 2;
  for(int j = 0; j < 2; j++) {
    rotate(outerTheta);
    beginShape();
    theta = TAU;
    angle = TAU / 6;
    for(int i = 0; i < 6; i++) {
      float x = sin(theta) * r3 / 3;
      float y = cos(theta) * r3 / 3;
      vertex(x, y);
      theta += angle;
    }
    endShape(CLOSE);
    outerTheta += outerAngle;
  }
  popMatrix();

  /**
   * Triángulos 
   */
  pushMatrix();
  outerTheta = TAU;
  outerAngle = TAU / 6;
  for(int i = 0; i < 2; i++) {
    rotate(outerTheta);
    outerTheta += outerAngle;
   
    theta = TAU;
    angle = TAU / 3;
    float c = 2 * (rI / 2) * sin(angle/2);

    float cX1 = sin(theta) * rI / 2;
    float cY1 = cos(theta) * rI / 2;
    float cX2 = sin(theta + angle) * rI / 2;
    float cY2 = cos(theta + angle) * rI / 2;

    
    
    beginShape();
    for(int j = 0; j < 3; j++) {
      float x = sin(theta) * rI / 2;
      float y = cos(theta) * rI / 2;
      vertex(x, y);
      theta += angle;
    }

    endShape(CLOSE);
  }
  popMatrix();

  /**
   * Pentágonos 
   */
  pushMatrix();
  // int axis  = 5;
  // outerAngle = TAU / axis;
  // outerTheta = TAU + outerAngle / 1.5;
  // for(int i = 0; i < 2; i++) {
  //   rotate(outerTheta);
  //   theta = TAU;
  //   angle = TAU / axis;
  //   beginShape();
  //   for(int j = 0; j < axis; j++) {
  //     float x = sin(theta) * rI / 2;
  //     float y = cos(theta) * rI / 2;
  //     vertex(x, y);
  //     theta += angle;
  //   }
  //   endShape(CLOSE);
  //   outerTheta += outerAngle;
  // }
  // popMatrix();

  popMatrix();
}