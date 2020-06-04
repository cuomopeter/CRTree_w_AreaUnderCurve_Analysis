# Assignment 7 - Peter Cuomo

# Question 1
 The optimal number of nodes, before relative error starts to increase, is **5**. 





```{r fig.width = 7, fig.height = 4.31, dpi = 144}
result <- crtree(
  CreditCardLoanNew, 
  rvar = "Noncurrent", 
  evar = c("CreditGrade", "Amount", "Age", "BorrowerRate", "DebtToIncomeRatio"), 
  type = "classification", 
  lev = "1", 
  data_filter = "Train==1"
)

plot(result, plots = "prune", custom = FALSE)
# plot(result, orient = "TD", width = "900px") %>% render()
```

# Question 2

* Age below 4.5 years is the largest leaf with the greatest number of observations. 
* The number of observations is **2,269** and the probability of the Noncurrent = 1 is **2.60%**

```{r}
result <- crtree(
  CreditCardLoanNew, 
  rvar = "Noncurrent", 
  evar = c("CreditGrade", "Amount", "Age", "BorrowerRate", "DebtToIncomeRatio"), 
  type = "classification", 
  lev = "1", 
  nodes = 5, 
  data_filter = "Train==1"
)
summary(result, prn = TRUE)

# plot(result, plots = "prune", custom = FALSE)
plot(result, orient = "TD", width = "900px") %>% render()
```
# Question 3

* The mean for pred_crtree1 is **.078** and the sd is **.093**.
* The mean for pred_crtree2 is **.078** and the sd is **.166**.


```{r}
result <- explore(
  CreditCardLoanNew, 
  vars = c("pred_crtree1", "pred_crtree2"), 
  fun = c("mean", "sd"), 
  data_filter = "Train==1", 
  nr = 2
)
summary(result)
# dtab(result) %>% render()
```

# Question 4 

* **Pred_crtree2** produces better cumulative gains on the training set. 

```{r fig.width = 7.54, fig.height = 5.38, dpi = 144}
result <- evalbin(
  CreditCardLoanNew, 
  pred = c("pred_crtree1", "pred_crtree2"), 
  rvar = "Noncurrent", 
  lev = "1", 
  train = "Training", 
  data_filter = "Train==1"
)
summary(result, prn = FALSE)
plot(result, plots = "gains", custom = FALSE)
```
* **Pred_crtree1** produces better cumulative gains on the test set. 

```{r fig.width = 7.54, fig.height = 5.38, dpi = 144}
result <- evalbin(
  CreditCardLoanNew, 
  pred = c("pred_crtree1", "pred_crtree2"), 
  rvar = "Noncurrent", 
  lev = "1", 
  train = "Test", 
  data_filter = "Train==1"
)
summary(result, prn = FALSE)
plot(result, plots = "gains", custom = FALSE)
```
# Question 5
* **Pred_crtree2** has a higher AUC for the training set. 


```{r}
result <- confusion(
  CreditCardLoanNew, 
  pred = c("pred_crtree1", "pred_crtree2"), 
  rvar = "Noncurrent", 
  lev = "1", 
  margin = 10, 
  train = "Training", 
  data_filter = "Train==1"
)
summary(result)
```


* **Pred_crtree1** has a higher AUC for the test set. 


```{r}
result <- confusion(
  CreditCardLoanNew, 
  pred = c("pred_crtree1", "pred_crtree2"), 
  rvar = "Noncurrent", 
  lev = "1", 
  margin = 10, 
  train = "Test", 
  data_filter = "Train==1"
)
summary(result)
```

# Question 6 
* For pred_crtree1:

Accuracy = (True Positive + True Negative)/Total 

         = (45+881)/1100
         
         = 84.18%

Precision = True Positive/Predicted Positive (False Positive+True Positive)

         = 45/(141+45)
         
         = 24.19%



# Question 7 

* Predicted Negative = False Negative + True Negative

                     = 881 + 33
                     
                     = 914
  
* **914** loans will be approved

* 33 out of the 914 predicted negative loans will actually be Noncurrent. The percentage is **3.61%**


# Question 8 

* **Pred_logit** produces better cumulative gains for the test set. 

```{r fig.width = 7.54, fig.height = 5.38, dpi = 144}
result <- evalbin(
  CreditCardLoanNew, 
  pred = c("pred_crtree1", "pred_logit"), 
  rvar = "Noncurrent", 
  lev = "1", 
  margin = 10, 
  train = "Test", 
  data_filter = "Train==1"
)
summary(result, prn = FALSE)
plot(result, plots = "gains", custom = FALSE)
```
* **Pred_logit** has the higher AUC for the test set.

```{r}
result <- confusion(
  CreditCardLoanNew, 
  pred = c("pred_crtree1", "pred_logit"), 
  rvar = "Noncurrent", 
  lev = "1", 
  margin = 10, 
  train = "Test", 
  data_filter = "Train==1"
)
summary(result)
```




