#!/usr/bin/env bashdemo
echo "Hello, Welcome to demo." | text2wave -o demo-welcome.ulaw -otype ulaw
echo "Please choose your function, 1: input authorization code, 2: ordering, 4: representative, 8: say current time. or call employee's 3 digits number." | text2wave -o demo-main.ulaw -otype ulaw
echo "Invalid input." | text2wave -o demo-invalid.ulaw -otype ulaw
echo "Timeout." | text2wave -o demo-timeout.ulaw -otype ulaw
echo "Call failure." | text2wave -o demo-failure.ulaw -otype ulaw
echo "Congrats, your order number and authorization code accepted." | text2wave -o demo-congrats.ulaw -otype ulaw
echo "Sorry, something wrong." | text2wave -o demo-Sorry.ulaw -otype ulaw
echo "Wow, your can ordering through demo irv system." | text2wave -o demo-ordering.ulaw -otype ulaw
echo "Wow, here is demo representative." | text2wave -o demo-representative.ulaw -otype ulaw
echo "Please input your order number, must be 9 digits." | text2wave -o demo-order.ulaw -otype ulaw
echo "Please input your authorization code, end by #." | text2wave -o demo-auth.ulaw -otype ulaw
echo "Thank you very much. Goodbye." | text2wave -o demo-thanks.ulaw -otype ulaw
echo "Your order number is:" | text2wave -o demo-order-code.ulaw -otype ulaw
echo "Your authorization code is:" | text2wave -o demo-auth-code.ulaw -otype ulaw



