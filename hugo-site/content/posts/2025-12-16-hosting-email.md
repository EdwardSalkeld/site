---
title: "Should we all start hosting our own email?"
date: 2025-12-16T21:00:00Z
---

Well, [Betteridge's law says the answer is no](https://en.wikipedia.org/wiki/Betteridge%27s_law_of_headlines), but let's put that aside a second.

I spent years working in a company with on-prem Exchange servers.
I never had to be very personally involved in them but I got the message loud and clear:
they weren't a lot of fun to maintain.
Internet facing. Regular security patches. Mountains of data.
100% uptime pretty much required. Ugh.

At the same time I was getting up to speed with Linux, playing around with a
Raspberry Pi v1 only shortly after they came out.
It was all brand new to me and I was reading around a _lot_.
And whilst my general feeling towards programming and sysadmin-ing in those early years
was that with free software and some learning you could do pretty much anything,
I kept reading the same negative message that warned about what you shouldn't do.
"Don't host your own email." Just don't do it.
Do anything else you like, but don't fly close to the sun, Icarus. Don't. Host. Email.

A subsequent job did little to change that impression.
We hosted the company email on Exim on our own hardware. It wasn't lovely.
My lasting memory is that the email server was the one piece of our kit that couldn't cope
with our network failover process. Cue lots of starting and restarting processes.
Prodding `/var/spool` queues in the hope they'd send.
Sending inbound test emails to see if they'd actually be delivered.

So, given all these battle scars... why would I even ask the question?

Well, the work that's gone into the [Stalwart labs](https://stalw.art/mail-server/)
mail server is seriously impressive ([GitHub](https://github.com/stalwartlabs/stalwart)).
I've been a Fastmail user for years now and their work developing the JMAP standard
has always seemed really interesting but ... I've never really seen much else that uses it.
The Stalwart server is JMAP everything (email, files, calendar) and looks really promising.

I don't know if hosting my own email is something I really want to do,
but I'm certainly going to have a go at setting it up and seeing how much work it is.
