# README

This is SMSr (pronounced "S-M-esser", because I think it's funny when tech products drop Es out of their names like in the 90s). It solves the problem of breaking several SMS texts into multiple parts. I took about two hours and fifteen minutes to put this together (excluding my generous lunch break). There are several things I'd like to do to finish this assignment properly, which I'll address below. You shouldn't need to do anything besides pull it down and run the test suite to see it in action. 

### 001-auth_and_gems

I started the project in api-only mode using a JWT auth system I picked up somewhere in my past that has been serving me well for quite a few years. My rubocop file has several personal tweaks that I find convenient but won't protest if I need to change them to match different linting standards. The gems besides rubocop, faker, pundit (for authorization) and rack-cors (added so this can talk to the front end or Postman) are necessary for an API to talk to a front end. The auth system has a custom error message system included. I created the User at this time becuse it's hard to test auth without users. I also threw in a bunch of test helper methods to make things easier for myself. I chose minitest instead of RSpec for this assignment because I'm faster with it, but I have no problem with RSpec.

### 002-sms_text_model

This model handles everything we need to know about these SMS messages. They belong to users so we can see who created what, but that doens't preclude us from allowing access to a Twitter-like dashboard that shows all SMS messages in real time or something of the sort. It's bare bones at this point but it will get filled in with the next commit. 

### 003-sms_texts_controller

Again, nothing mind-blowing here. Just setting up proper endpoints that the front end can interact with. 

### 004-split_sms_texts

Here's the meat of the project. The before_action lets us check if the text is longer than the 160 character limit. If it is not, it is created as normal. If it is, we run a method (that I ran out of refactoring time for) that splits it into different text chunks that are stored as an array on the original object. The main method first creates an array to hold all the parts of the text. To break it, we know we'll need to start at 0 and end at 151 so we have room to add '- part n'. There are a lot of +1s and -1s to account for zero indexing. Once we know what we need to break where, start a generic loop that goes through the body of the SmsText, breaking it into smaller and smaller pieces as it goes. We adjust the index numbers before we enter the next loop, and we break out of it if the starting index is higher than the number of characters left. We use #rpartition on the body of the SmsText in order to break the sentence at the last space, using the size of this string to adjust our starting point for the next iteration. 

### Additional concerns

I ran out of time before I could implement 1) a sensible way of saving these as inidividual records (such as having a parent_sms_text_id field on multipart texts), 2) a serious refactoring of the enforce_character_limit method because rubocop disagress with the AbcSize as it is now, along with 3) more thorough testing of the model post-refactoring. If I had a day with this, I'd come out with some Postman documentation on the whole thing, including saving the auth token as variables to automate things nicely. 

Of course, in all things programming, how you put things in the database and how you take them out depend heavily on what you plan to do with them. I'd want more details on what this service is meant to do for whom in what manner. 
