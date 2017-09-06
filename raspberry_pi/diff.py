#! /usr/bin/env python

import smbus, time
import imaplib
import os

from acm1602 import acm1602

SERVER_NAME = "imap.gmail.com"

USERNAME = os.environ["GMAIL_USERNAME"]
PASSWORD = os.environ["GMAIL_PASSWORD"]

mail = imaplib.IMAP4_SSL(SERVER_NAME)

mail.login(USERNAME, PASSWORD)

mail.list()

mail.select("Inbox")

(st, mlist) = mail.status('Inbox', "(UNSEEN)")

if (st == "OK"):
    lcd = acm1602(1, 0x50, 4)

    lcd.move_home()

    lcd.set_cursol(0)

    lcd.set_blink(0)

    mcount = int(mlist[0].split()[2].strip(').,]'))

    if (mcount > 0):
        lcd.backlight(1)
        lcd.write("You got")

        lcd.move(0x00, 0x01)

        lcd.write("   " + str(mcount) + "Mail.")

    else:
        lcd.backlight(0)

        lcd.write("No new mail.")

else:

    print("Can't get Mail status.")
mail.close()

mail.logout()
