> Images

### `RC522-RFID-Reader-Module-Pinout.jpg`
![RC522-RFID-Reader-Module-Pinout.jpg](./pic/RC522-RFID-Reader-Module-Pinout.jpg 'RC522-RFID-Reader-Module-Pinout.jpg')

### `connection.jpg`
![connection.jpg](./pic/connection.jpg 'connection.jpg')

> ## Code Files

### `nfc_telegram_bot.ino`
```
#include <MFRC522.h>
#include <SPI.h>
#include <ESP8266WiFi.h>
#include <WiFiClientSecure.h>
#include <UniversalTelegramBot.h>

const char RST_PIN = D1;
const char SS_PIN = D2;
const int buzzer_pin = D3;
const int led_pin = D4;
const char* ssid = "WiFi";
const char* password = "akash@wifi";

#define botToken "6295891770:AAHlv-TUpbxskHYoganEpU6cHzlyHVtI_Hs"
#define chatId "1087624732"

/*Initial Setup*/
X509List cert(TELEGRAM_CERTIFICATE_ROOT);
WiFiClientSecure client;
UniversalTelegramBot bot(botToken, client);
MFRC522 mfrc522(SS_PIN, RST_PIN);  // Create MFRC522 instance

/*Extra Functions*/
void indicator(int arg) {
  if (arg == 1) {
    digitalWrite(led_pin, HIGH);
    digitalWrite(buzzer_pin, HIGH);
  } else {
    digitalWrite(led_pin, LOW);
    digitalWrite(buzzer_pin, LOW);
  }
}


void setup() {
  Serial.begin(9600);

  /*Telegram setup*/
  configTime(0, 0, "pool.ntp.org");
  client.setTrustAnchors(&cert);  // Add root certificate for api.telegram.org

  /*Pins*/
  pinMode(led_pin, OUTPUT);
  pinMode(buzzer_pin, OUTPUT);
  digitalWrite(buzzer_pin, HIGH);
  delay(500);
  digitalWrite(buzzer_pin, LOW);

  /*RFID setup*/
  SPI.begin();         // Init SPI bus
  mfrc522.PCD_Init();  // Init MFRC522 card
  Serial.println("RFID reader is ready");

  /*Wifi setup*/
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    digitalWrite(led_pin, HIGH);
    delay(500);
    digitalWrite(led_pin, LOW);
    delay(500);
  }
  Serial.println(WiFi.localIP());
}

void loop() {
  if (mfrc522.PICC_IsNewCardPresent() && mfrc522.PICC_ReadCardSerial()) {
    digitalWrite(buzzer_pin, HIGH);

    String tagId = "";
    for (byte i = 0; i < mfrc522.uid.size; i++) {
      tagId += String(mfrc522.uid.uidByte[i], HEX);
    }
    Serial.println(tagId);
    indicator(1);

    bot.sendMessage(chatId, getname(tagId), "");

    mfrc522.PICC_HaltA();
    delay(200);
    indicator(0);
  }
}

String getname(String tagid) {
  Serial.println("......");
  // Serial.println("this is tagid: " + tagid);
  String t = "this is tagid: " + tagid;
  return t;
}
```

## Budgets

###  `price.csv`
| ITEMS    | PRICE |
| -------- | ----- |
| Nodemcu  | 300   |
| Rfid kit | 200   |
| Tag * 20 | 400   |
| SUM      | 900   |


## Other Files

- [nfc_telegram_bot.ino.bin](./code/nfc_telegram_bot/build/esp8266.esp8266.nodemcuv2/nfc_telegram_bot.ino.bin)

- [nfc_telegram_bot.ino.elf](./code/nfc_telegram_bot/build/esp8266.esp8266.nodemcuv2/nfc_telegram_bot.ino.elf)

- [nfc_telegram_bot.ino.map](./code/nfc_telegram_bot/build/esp8266.esp8266.nodemcuv2/nfc_telegram_bot.ino.map)
