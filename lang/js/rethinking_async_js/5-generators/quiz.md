1)  What is "callback hell"? Why do callbacks suffer from "inversion of control" and "unreasonability"?

- "Callback" hell refers to the deficiency of the callback pattern.  It is not capable of addressing issues with IoC and non-local, non-sequential reasoning.
- Callbacks suffer from "inversion of control" because the responsibility for calling the callback is transferred to a 3rd party api.
- Callbacks suffer from "unreasonability" because our brain works in a local, sequential reasoning.


2) What is a "promise"? How does it solve inversion of control issues?

- "promise" is...
    - a placeholder for a future value
    - completion event ('then' event)
    - callback manager

- solves IoC by giving 3rd party ability to give a 'trustable system' back to us.


3) How to pause a generator? How do you resume a generator?
- yield
- call 'next()'

4) How do we combine generators and promises for flow control?
- yield a promise


