/**
 * https://github.com/bardiel/mandala_uno
 * 
 * @author Bardiel W. Thirtytwo <bardiel@bardiel.com.ar>
 * @version 0.0.0
 * @since 2015-04-05
 */

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
  PVector outerPoints[] = new PVector[60];
  float angle = TAU / outerPoints.length;
  float theta = TAU;
  for(int i = 0; i < outerPoints.length; i++) {
    float x = sin(theta) * rO / 2;
    float y = cos(theta) * rO / 2;
    outerPoints[i] = new PVector(x, y);
    // fill(255);
    // ellipse(x, y, 5, 5); //círculo para marcar los puntos
    theta += angle;
  }


  /**
   * Puntos para el círculo interno
   */
  PVector innerPoints[] = new PVector[outerPoints.length * 2];
  angle = TAU / innerPoints.length;
  theta = TAU + (angle / 2);
  for(int i = 0; i < innerPoints.length; i++) {
    float x = sin(theta) * rI / 2;
    float y = cos(theta) * rI / 2;
    innerPoints[i] = new PVector(x, y);
    // fill(255,0,0);
    // ellipse(x, y, 5, 5); //círculo para marcar los puntos
    theta += angle;
  }

  noFill();

  /** 
   * Las liñítas entre los círculos
   */
  for(int i = 0; i < innerPoints.length; i+=2) {
    line(innerPoints[i].x, innerPoints[i].y, outerPoints[i/2].x, outerPoints[i/2].y);
  }

  for(int i = 1; i < innerPoints.length; i+=2) {
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
  theta = TAU;
  for(int i = 0; i < 16; i++ ) {
    float xx = sin(theta) * r3 / 5.5;
    float yy = cos(theta) * r3 / 5.5;
    line(0, 0, xx, yy);
    theta += angle;
  }

  /**
   * Una flarcita para el medio, también
   * (probar los óvalos y flor al mismo tiempo ;))
   */
  // angle = TAU / 12;
  // theta = TAU;
  // ellipse(0, 0, r3 / 4, r3 / 4);
  // // beginShape();
  // for(int i = 0; i < 12; i++) {
  //   float x = sin(theta) * r3 / 8;
  //   float y = cos(theta) * r3 / 8;
  //   float xx = sin(theta) * r3 / 5.5;
  //   float yy = cos(theta) * r3 / 5.5;
  //   ellipse(x, y, r3 / 4, r3 / 4);
  //   // vertex(xx, yy);
  //   line(0, 0, xx, yy);
  //   // ellipse(xx, yy, 5, 5);
  //   theta += angle;
  // }
  // // endShape(CLOSE);

  /** 
   * Los hexágonos del medio
   */
  pushMatrix();
  float outerAngle = TAU / 7;
  float outerTheta = TAU;
  for(int j = 0; j < 5; j++) {
    if((j + 1 ) % 2 == 0) rotate(outerTheta);
    else rotate(outerTheta * -1);
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
    outerTheta += outerAngle ;
  }
  popMatrix();

  /**
   * Triángulos para un lado
   */
  pushMatrix();
  outerAngle = TAU / 6;
  outerTheta = TAU + outerAngle / 1.5;

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
   * Triángulos pa'l otro lado
   */
  pushMatrix();
  outerAngle = TAU / 6;
  outerTheta = TAU - outerAngle / 1.5;

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
  // pushMatrix();
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


  /**
   * Pentágonos para afuera
   */
  pushMatrix();
  outerAngle = TAU / 7;
  outerTheta = TAU + outerAngle;
  for(int j = 1; j < 5; j++) {
    if((j + 1 ) % 2 == 0) rotate(outerTheta);
    else rotate(outerTheta * -1);
    beginShape();
    theta = TAU;
    angle = TAU / 5;
    for(int i = 0; i < 5; i++) {
      // float x = sin(theta) * rO / 1.725;
      // float y = cos(theta) * rO / 1.725;
      float x = sin(theta) * rO / 1.6;
      float y = cos(theta) * rO / 1.6;
      vertex(x, y);
      theta += angle;
    }
    endShape(CLOSE);
    outerTheta += outerAngle;
  }
  popMatrix();

  /**
   * Hexágonos para afuera
   */
  // pushMatrix();
  // outerAngle = TAU / 7;
  // outerTheta = TAU;
  // for(int j = 0; j < 5; j++) {
  //   if((j + 1 ) % 2 == 0) rotate(outerTheta);
  //   else rotate(outerTheta * -1);
  //   beginShape();
  //   theta = TAU;
  //   angle = TAU / 6;
  //   for(int i = 0; i < 6; i++) {
  //     // float x = sin(theta) * rO / 1.725; //con éstos queda JUSTO sobre la circunsferencia
  //     // float y = cos(theta) * rO / 1.725;
  //     float x = sin(theta) * rO / 1.7;
  //     float y = cos(theta) * rO / 1.7;
  //     vertex(x, y);
  //     theta += angle;
  //   }
  //   endShape(CLOSE);
  //   outerTheta += outerAngle;
  // }
  // popMatrix();

  /**
   * Hojitas y pistilos
   * TO DO: hacer los tamaños relativos
   */
  angle = TAU / 5;
  theta = TAU;
  // fill(255);
  for(int i = 0; i < 5; i++) {
    pushMatrix();
    float x = sin(theta) * rO * 0.525;
    float y = cos(theta) * rO * 0.525;
    // line(x, y, xx, yy);
    translate(x, y);
    rotate(-theta);
    line(0,0,0,50);

    bezier(0, 0, 10, 10, 20, 10, 0, 50);

    bezier(0, 0, -10, 10, -20, 10, -0, 50);

    bezier(0, 0, 10, 10, 40, 5, 20, 70);
    bezier(0, 0, 10, 5, 30, 5, 10, 60);

    bezier(0, 0, -10, 10, -40, 5, -20, 70);
    bezier(0, 0, -10, 5, -30, 5, -10, 60);

    fill(210);
    ellipse(20, 70, 5, 5);
    ellipse(10, 60, 5, 5);
    ellipse(-20, 70, 5, 5);
    ellipse(-10, 60, 5, 5);
    noFill();

    theta += angle;
    popMatrix();
  }

  /**
   * Circulitos entre los triángulos de adentro
   */
  angle = TAU / 6;
  theta = TAU;
  fill(210);
  for(int i = 0; i < 6; i++) {
    float x = sin(theta) * rI * -0.33;
    float y = cos(theta) * rI * -0.33;
    ellipse(x, y, 10, 10);
    // x = sin(theta) * rI * -0.265;
    // y = cos(theta) * rI * -0.265;
    // ellipse(x, y, 10, 10);
    theta += angle;
  }
  popMatrix();
}