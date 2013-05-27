Cureency / Numeric TextField and Label
==========================

![Alt text](/main.png)

<pre><code>
	numericField1.currencyPrefix = @"$";
	numericField1.text = @"12345";
	numericField1.decimalCount = 2;
	[numericField1 becomeFirstResponder];

	numericField2.currencyPrefix = @"\\";
	numericField2.text = @"1085";
	
	numericLabel.text = @"1085";
	numericLabel.currencyPrefix = @"\\";

	numericLabel.text = [NSString stringWithFormat:@"%d", (int)([numericField1.numericString doubleValue] * [numericField2.numericString doubleValue])];
</code></pre>
