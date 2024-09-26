# Practical-Machine-Learning
<h2>SYNOPSIS</h2> 
For this dataset participants were asked to perform one set of 10 repetitions of unilateral dumbbell biceps curl in 5 different styles, the outcome variable is classe.


<h2>Data Description</h2> 
<p>The outcome variable is classe, a factor variable with 5 levels. For this data set, participants were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in 5 different fashions:

exactly according to the specification (Class A)
throwing the elbows to the front (Class B)
lifting the dumbbell only halfway (Class C)
lowering the dumbbell only halfway (Class D)
throwing the hips to the front (Class E)</p>


<h2>Cross-validation</h2>
<p>In this section cross-validation will be performed by splitting the training data in training (75%) and testing (25%) data.</p>

<h2>Result</h2>
<p>The confusion matrices indicate that the Random Forest algorithm outperforms decision trees. The accuracy for the Random Forest model was 0.995 (95% CI: (0.993, 0.997)), while the Decision Tree model achieved an accuracy of 0.739 (95% CI: (0.727, 0.752)). Therefore, the Random Forest model is selected.</p>



<h2>Conclusion</h2>
<p>The anticipated out-of-sample error is estimated to be 0.005, or 0.5%. This out-of-sample error is determined by calculating 1 minus the accuracy of predictions made on the cross-validation set. Our test dataset consists of 20 cases. Given an accuracy exceeding 99% on the cross-validation data, we can expect that very few, if any, of the test samples will be misclassified.</p>
</div>
</div>
</body>