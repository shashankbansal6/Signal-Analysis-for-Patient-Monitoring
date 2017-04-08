# Signal-Analysis-for-Patient-Monitoring
<p>A reliable patient monitoring system which analyzes the correlated physiological signals collected from the patient's body, and generates alarms for abnormalities.</p>
<p>The system uses 3 physiological signals collected from the biomedical sensors attached to the patient body.</p>
<p>S1: Heart Rate (HR)</p>
<p>S2: Pusle Rate (PR)</p>
<p>S3: Respiration Rate (RESP)</p>

<p>The following is the design figure used to build the monitoring system where </p>
*The signals are passed through three processing units, called threshold functions, to detect patient abnormalities.
*Each threshold function generates an alarm whenever a data sample of the corresponding signal exceeds a pre-defined threshod. A "1" on the output of each function indicates an alarm and a "0" corresponds to absence of an alarm. 
*A majority voter function then generates the final output, based on the value of that the majority of the threshold functions agreed upon.

![System Design](https://github.com/shashankbansal6/Signal-Analysis-for-Patient-Monitoring/blob/master/System_Figure.JPG)
