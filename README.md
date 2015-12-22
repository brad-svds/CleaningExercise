# CleaningExercise
This is a Course Project for Class #3 of the Data Science Certificate.

## STUDY DESIGN (as provided in the README.txt of the original data)

The experiments have been carried out with a group of 30 volunteers within an age bracket 
of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, 
SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded 
accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a 
constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained 
dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for 
generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and 
then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The 
sensor acceleration signal, which has gravitational and body motion components, was separated using a 
Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to 
have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each 
window, a vector of features was obtained by calculating variables from the time and frequency domain. 
See 'features_info.txt' for more details.

## PREPARING THE DATA

The output of the script will provide two tables, tidy_data_largeset.txt and tidy_data.txt.

* tidy_data_largeset: This includes the training and test data set from Samsung, merged, and includes
only the measurements on the mean and standard deviation. Feature titles are cleaned for understanding.
* tidy_data: This fileset takes the prior created dataset and calculates the mean for each variable on 
each activity/subset.

**Process:**

First, set a common working directory for downloading the information and include the appropriate packages
Then, the fitness tracking data is saved locally and unzipped. I created a 'filenames' data structure to
determine the file paths I would need for the exercise.

To remove the columns calculating mean and std values, I relabeled the columns with the inforomation
from the 'features.txt' file. Using grep, I then removed all columns that don't focus specifically on 
means and standard deviations. After doing this for the training set, I repeat the process for the test set.


I then merged the Cleaned Training and Test sets together, and binded the Subject and Activity Data to have 
a full set. For the activity set, I first performed a join to include the full description of the activity.
The second tidy dataset uses ddlpy to split the dataframe are return the mean of each level.

## CODE BOOK

The code book is designed to describe each variable and its units.

* *"subjectvalue"*: The corresponding ID for the subject used in the study               
* *"rawactivity"*: The numerical value of the activity taking place during measurement                 
* *"subjectactivity"*: The character value of the activity taking place during measurement            
* *"timedomainbodyaccelerometermagmean()"*: Mean of time domain signals on body measurements using an accelerometer          
* *"timedomainbodyaccelerometermagstd()"*: St Dev of time domain signals on body measurements using an accelerometer        
* *"timedomaingravityaccelerometermagmean()"*: Mean of time domain signals on gravity measurements using an accelerometer      
* *"timedomaingravityaccelerometermagstd()"*: St Dev of time domain signals on gravity measurements using an accelerometer       
* *"timedomainbodyaccelerometerjerkmagmean()"*: Mean of time domain signals in which body linear acceleration and angular 
velocity are derived in time to obtain Jerk signals using an accelerometer    
* *"timedomainbodyaccelerometerjerkmagstd()"*: St Dev of time domain signals in which body linear acceleration and angular 
velocity are derived in time to obtain Jerk signals using an accelerometer     
* *"timedomainbodygyroscopemagmean()"*: Mean of time domain signals on body measurements using a gyroscope        
* *"timedomainbodygyroscopemagstd()"*: St Dev of time domain signals on body measurements using a gyroscope         
* *"timedomainbodygyroscopejerkmagmean()"*: Mean of time domain signals in which body linear acceleration and angular 
velocity are derived in time to obtain Jerk signals using a gyroscope   
* *"timedomainbodygyroscopejerkmagstd()"*: St Dev of time domain signals in which body linear acceleration and angular 
velocity are derived in time to obtain Jerk signals using a gyroscope       
* *"frequencydomainbodyaccelerometermagmean()"*: Mean of Fast Fourier Transform (FFT) on body measurements using an accelerometer          
* *"frequencydomainbodyaccelerometermagstd()"*: St Dev of Fast Fourier Transform (FFT) on body measurements using an accelerometer        
* *"frequencydomainbodybodyaccelerometerjerkmagmean()"*: Mean of Fast Fourier Transform (FFT) in which body linear acceleration and angular 
velocity are derived in time to obtain Jerk signals using an accelerometer
* *"frequencydomainbodybodyaccelerometerjerkmagstd()"*: St Dev of Fast Fourier Transform (FFT) in which body linear acceleration and angular 
velocity are derived in time to obtain Jerk signals using an accelerometer  
* *"frequencydomainbodybodygyroscopemagmean()"*: Mean of Fast Fourier Transform (FFT) on body measurements using a gyroscope  
* *"frequencydomainbodybodygyroscopemagstd()"*: St Dev of Fast Fourier Transform (FFT) on body measurements using a gyroscope     
* *"frequencydomainbodybodygyroscopejerkmagmean()"*: Mean of Fast Fourier Transform (FFT) in which body linear acceleration and angular 
velocity are derived in time to obtain Jerk signals using a gyroscope
* *"frequencydomainbodybodygyroscopejerkmagstd()"*: St Dev of Fast Fourier Transform (FFT) in which body linear acceleration and angular 
velocity are derived in time to obtain Jerk signals using a gyroscope
