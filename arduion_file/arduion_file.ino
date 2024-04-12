int ledPin = 5; // LED connected to digital pin 5
int vib_pin = A0;
unsigned long previousMillis = 0; // Stores last time sensor was updated
const long interval = 100; // Interval at which to read sensor (milliseconds)
int IRSensor = 9; // connect IR sensor module to Arduino pin D9
void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(vib_pin, INPUT);
  pinMode(IRSensor, INPUT); // IR Sensor pin INPUT
}

void loop() {
  unsigned long currentMillis = millis();
  int IRstatus = digitalRead(IRSensor);
  if (Serial.available() > 0) {
    char receivedChar = Serial.read(); // Read the incoming byte
    if (receivedChar == '1') {
      digitalWrite(ledPin, HIGH); // Turn LED on
    } else if (receivedChar == '0') {
      digitalWrite(ledPin, LOW); // Turn LED off
    }
  }
  
  // Check if it's time to read the vibration sensor
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis; // Save the last time you read the sensor
    int val = analogRead(vib_pin);
    // Assuming you want to filter raw values under 1000 to reduce noise

      Serial.println(val - 950+IRstatus*100); // Send adjusted value to Bluetooth
  }
}
