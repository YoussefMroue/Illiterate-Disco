# Illiterate-Disco
Data Science and Machine Learning Semester 2 final Project
##### Introduction
One of the most frequent reasons people have cited for not voting is that "both parties are the same." At its core, this argument claims that one's vote does not matter because no matter which party gets elected, the resulting policies will be the same. In our analysis, we attempt to determine whether or not there is any merit to this claim. In particular, we want to answer the following question:  

Does the party afiliation of a politician predict how the politician will vote?  

To answer this question, we analyzed the 2012 House of Representatives roll call voting record, which we scraped from the congressional bulk data site using the Congress data downloader tool (https://github.com/unitedstates/congress). The data set consists of 435 observations (one row for each representative) of 659 variables. The variables include name, party (D/R), and their vote in each of the 657 roll call votes of the session by the representative for dierent issues (Yay (Y), Nay (N), Present (P), and Not Voting (O)). Because we do not have any categories (i.e as conservative, libertarian, progressive, etc) for voting behavior, we must rst nd natural groupings in the voting behavior of represen- tatives. This is a task naturally geared towards unsupervised learning. Once we have these natural groupings, we can then analyze the clusters to determine the answer to our question.

