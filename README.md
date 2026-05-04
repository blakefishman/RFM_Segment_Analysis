## Background
**New Haven Printworks** is a local US printing service specializing in custom printed products for online ordering and physical pickup, including business cards, greeting cards, posters, art prints, and photo books. To better understand its local customer base, the business sought to conduct an **RFM (Recency, Frequency, Monetary) segmentation analysis** on March 6, 2026, against their 2025 sales data.

The business was particularly interested in their top-performing customers, as they also intend to use the RFM analysis findings to help guide the launch of a new loyalty program, however they are still uncertain on the best rollout strategy.

This analysis processes New Haven Printworks’ 2025 sales data into an RFM customer segmentation analysis to uncover key customer insights, driving actionable recommendations to boost future performance. The RFM segmentation utilized deciles for ten equal parts, resulting in scores of 3–30 across eight customer segments.



## Project Components

* The data was loaded into **Google BigQuery** using **Fivetran**, and can be found [here](https://github.com/blakefishman/RFM_Segment_Analysis/tree/main/Data).

* The **SQL** queries used to examine the data and perform quality checks can be found [here](https://github.com/blakefishman/RFM_Segment_Analysis/blob/main/SQL%20Queries/Initial%20Data%20Checks%20and%20Examining.sql).

* The **SQL** queries used to calculate the RFM analysis for visualization and analysis be found [here](https://github.com/blakefishman/RFM_Segment_Analysis/blob/main/SQL%20Queries/RFM%20Analysis.sql).

* The **Power BI** dashboard visualizations can be found [here](https://github.com/blakefishman/RFM_Segment_Analysis/blob/main/RFM_Dashboard_PowerBI.pbix).


## Executive Summary
New Haven Printworks possesses a moderately concentrated revenue distribution, with the top 22% of customers ('VIP' and 'Loyalist' segments) driving 40% of total revenue against a bottom 20% driving just 5%. Meanwhile, the 'Engaged' segment is the single largest segment at 22% of the customer base while contributing 17% of total revenue, and offers a large, receptive, and potentially underutilized group of customers for targeted marketing campaigns.

Key recommendations focus on launching the upcoming loyalty program exclusively with VIP customers first, pursuing targeted upsell strategies for Loyalist and Potential Loyalist segments, and deploying win-back campaigns to mitigate potential churn that could reach 14.3% if all At-Risk customers are lost.

<div align="center">
  <img width="700px" src="https://github.com/user-attachments/assets/b6d12fb7-cf14-4d65-b048-dcb93a552826" />
</div>

## Insights Deep-Dive

* Across all segments, the average customer profile is 161 days since last purchase, having placed between 3 and 4 total orders with an average historical customer lifetime value of $59.47.

* **The top 22% of customers account for 40% of revenue** (comprising the 'VIP' and 'Loyalist' segments), while **the bottom 20% contribute roughly 5%**. This reflects a more diversified revenue stream across customer segments compared to some standard benchmarks.

* Our top customers ('VIP' segment) represent 7% of total customers yet average $128.47 in total customer spend, which is **roughly 2x the overall average**. With high Frequency, **their share of total revenue is double their share of total customers (14% vs 7%)**.

* The 'Loyalist' and 'Potential Loyalist' segments **together represent over a quarter of the customer base (29%) but drive almost half of total revenue (43.6%)**. With an average revenue of $89.76, both segments contribute a disproportionate share of revenue relative to their customer sizes. This correlation is partly expected, as higher spending naturally results in a higher Monetary score for RFM scoring, and as such the effect appears more significantly among 'VIP' customers as well.

* **The 'Engaged' segment is the single largest segment**, at 22% of the customer base. They contribute 17% of total revenue, maintaining an average total customer spend of $46 across a 2.8 order average.

* **The 'Promising' segment is the inflection point where the relationship between customer volume and revenue begins to flip**. In lower-tier segments, customer share exceeds revenue share, but as customers move to higher RFM segments, their increased spend drives a shift where revenue share outweighs customer share. With equal 15% and 15% shares, their ratio of customer share versus revenue share is 1:1.

* Confirmed customer churn is stable at 1.7%. Possible churn through the loss of all 'At Risk' customers could increase total churn to 14.3%, totaling $683.72 - about 4% of total revenue.

* Customer #0293 is the only customer to have purchased over 10 times, and thus has a Frequency of 12.


<div align="center">
  <img width="700px" src="https://github.com/user-attachments/assets/ff6d59ea-90ec-4765-a4db-3baeeee17c54" />
</div>


## Recommendations

* 'VIPs' are truly a small but exceptional group and at only 6.6% of the customer base, **protecting them with exclusive retention efforts is critical**. This includes early introduction into the upcoming loyalty program:

* **Soft launch the loyalty program with our top customers (the 'VIP' segment) first** to capitalize on their high responsiveness and willingness. While also serving as a retention strategy, their participation allows for gathering critical feedback that can be used to refine the program as needed before a wider rollout.

* Prioritize upselling to 'Loyalists' and 'Potential Loyalists' to graduate them into higher segments. When the timeline makes sense, these segments can also be integrated into the loyalty program to further their retention.

* Run targeted, personalized offers to increase loyalty and spend among customers in the 'Engaged' segment, which is the single largest segment. This customer segment offers a large, already receptive, and potentially underutilized group of customers.

* Implement win-back campaigns to reengage 'At Risk' and 'Requires Attention' customers, while also mitigating potential churn.

* Approximately 10 high-value customers (3.48% of total base) in the 'Loyalist' and 'Potential Loyalist' segments meet or exceed the 'VIP' Frequency (6) and roughly match its average total customer spend ($126.81 vs $128.47), but lag in Recency. **Targeted return offers to improve their Recency scores could thus graduate most of these customers into the 'VIP' segment**, bolstering it ahead of the loyalty program's initial launch phase while diversifying some revenue away from the 'Loyalist' segment's current 26%
