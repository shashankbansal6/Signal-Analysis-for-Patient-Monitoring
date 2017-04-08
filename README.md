# Signal-Analysis-for-Patient-Monitoring
<p>A reliable patient monitoring system which analyzes the correlated physiological signals collected from the patient's body, and generates alarms for abnormalities.</p>
<p>The system uses 3 physiological signals collected from the biomedical sensors attached to the patient body.</p>
<p>S1: Heart Rate (HR)</p>
<p>S2: Pusle Rate (PR)</p>
<p>S3: Respiration Rate (RESP)</p>

<p>The following is the design figure used to build the monitoring system where </p>
<ul>
<li>The signals are passed through three processing units, called threshold functions, to detect patient abnormalities. </li>
<li>Each threshold function generates an alarm whenever a data sample of the corresponding signal exceeds a pre-defined threshod. A "1" on the output of each function indicates an alarm and a "0" corresponds to absence of an alarm. </li>
<li>A majority voter function then generates the final output, based on the value of that the majority of the threshold functions agreed upon.
</li>
</ul>

![System Design](https://github.com/shashankbansal6/Signal-Analysis-for-Patient-Monitoring/blob/master/System_Figure.JPG)

<p>The following are the threshold values used: </p>

<table>
<thead>
<tr>
<th>Signals</th>
<th align = "center">Empirical Thresholds</th>
<th align = "right">Theoretical Thresholds</th>
</tr>
</thead>
<tbody>
<tr>
<td>Heart Rate (HR) </td>
<td align = "center"> a = 80.17, b = 98.52</td>
<td align = "right"> a = 78.84, b = 96.83</td>
</tr>

<tr>
<td>Pressure Rate (PR) </td>
<td align = "center"> a = 79.00, b = 97.07</td>
<td align = "right"> a = 78.15, b = 96.09</td>
</tr>
</tbody>
</table>

