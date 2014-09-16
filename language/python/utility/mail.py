#!/usr/bin/env python
import smtplib
from email.mime.text import MIMEText


class Mail:
  def __init__(self, host, user, password, toList):
    self.host = host
    self.user = user
    self.password = password
    self.toList = toList

  def send(self, subject, content, name=''):
    me = name + '<' + self.user + '>'
    msg = MIMEText(content, _subtype='plain', _charset='utf8')
    msg['Subject'] = subject
    msg['From'] = me
    msg['To'] = ';'.join(self.toList)

    try:
      server = smtplib.SMTP()
      server.connect(self.host)
      server.login(self.user, self.password)
      server.sendmail(me, self.toList, msg.as_string())
      server.close()

      return True
    except Exception as e:
      print str(e)

      return False
