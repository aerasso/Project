==================================================================

Getting and Cleaning Data

Course Project
Alejandro Erasso

==================================================================

Background Summary:

Experiments under the Human Activity Recognition Using Smartphones Dataset
have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, 
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded 
accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the 
data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of 
the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise 
filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap 
(128 readings/window). The sensor acceleration signal, which has gravitational and body 
motion components, was separated using a Butterworth low-pass filter into body acceleration 
and gravity. The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 
561 features was obtained by calculating variables from the time and frequency domain.

==================================================================

This Code:

run_analysis.R

This R code reads wearable data from the "Human Activity Recognition Using Smartphones Data Set" 
and cleans them to provide a tidy data set with the mean values of the subject and activity 
measurements.

See CodeBook.md for the data dictionary of the output file, named "tidy_wearable_data.txt".
 
Output:

tidy_wearable_data.txt

tidy_wearable_data can be read into R with read.table(header=TRUE) and "\t" separator

==================================================================

Credits:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

License:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
