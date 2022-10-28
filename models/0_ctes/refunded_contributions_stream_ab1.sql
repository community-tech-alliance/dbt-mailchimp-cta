{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mailchimp",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('mailchimp', '_airbyte_raw_refunded_contributions_stream') }}
select
    {{ json_extract_scalar('_airbyte_data', ['Fee'], ['Fee']) }} as Fee,
    {{ json_extract_scalar('_airbyte_data', ['Date'], ['Date']) }} as Date,
    {{ json_extract_scalar('_airbyte_data', ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract_scalar('_airbyte_data', ['Mobile'], ['Mobile']) }} as Mobile,
    {{ json_extract_scalar('_airbyte_data', ['Approved'], ['Approved']) }} as Approved,
    {{ json_extract_scalar('_airbyte_data', ['Comments'], ['Comments']) }} as Comments,
    {{ json_extract_scalar('_airbyte_data', ['Donor ID'], ['Donor ID']) }} as Donor_ID,
    {{ json_extract_scalar('_airbyte_data', ['Apple Pay'], ['Apple Pay']) }} as Apple_Pay,
    {{ json_extract_scalar('_airbyte_data', ['Donor ZIP'], ['Donor ZIP']) }} as Donor_ZIP,
    {{ json_extract_scalar('_airbyte_data', ['Recipient'], ['Recipient']) }} as Recipient,
    {{ json_extract_scalar('_airbyte_data', ['Refund ID'], ['Refund ID']) }} as Refund_ID,
    {{ json_extract_scalar('_airbyte_data', ['Check Date'], ['Check Date']) }} as Check_Date,
    {{ json_extract_scalar('_airbyte_data', ['Donor City'], ['Donor City']) }} as Donor_City,
    {{ json_extract_scalar('_airbyte_data', ['Partner ID'], ['Partner ID']) }} as Partner_ID,
    {{ json_extract_scalar('_airbyte_data', ['Payment ID'], ['Payment ID']) }} as Payment_ID,
    {{ json_extract_scalar('_airbyte_data', ['Receipt ID'], ['Receipt ID']) }} as Receipt_ID,
    {{ json_extract_scalar('_airbyte_data', ['Donor Addr1'], ['Donor Addr1']) }} as Donor_Addr1,
    {{ json_extract_scalar('_airbyte_data', ['Donor Addr2'], ['Donor Addr2']) }} as Donor_Addr2,
    {{ json_extract_scalar('_airbyte_data', ['Donor Email'], ['Donor Email']) }} as Donor_Email,
    {{ json_extract_scalar('_airbyte_data', ['Donor Phone'], ['Donor Phone']) }} as Donor_Phone,
    {{ json_extract_scalar('_airbyte_data', ['Donor State'], ['Donor State']) }} as Donor_State,
    {{ json_extract_scalar('_airbyte_data', ['Double Down'], ['Double Down']) }} as Double_Down,
    {{ json_extract_scalar('_airbyte_data', ['Lineitem ID'], ['Lineitem ID']) }} as Lineitem_ID,
    {{ json_extract_scalar('_airbyte_data', ['Merchant ID'], ['Merchant ID']) }} as Merchant_ID,
    {{ json_extract_scalar('_airbyte_data', ['Recovery ID'], ['Recovery ID']) }} as Recovery_ID,
    {{ json_extract_scalar('_airbyte_data', ['Refund Date'], ['Refund Date']) }} as Refund_Date,
    {{ json_extract_scalar('_airbyte_data', ['AB Test Name'], ['AB Test Name']) }} as AB_Test_Name,
    {{ json_extract_scalar('_airbyte_data', ['AB Variation'], ['AB Variation']) }} as AB_Variation,
    {{ json_extract_scalar('_airbyte_data', ['Check Number'], ['Check Number']) }} as Check_Number,
    {{ json_extract_scalar('_airbyte_data', ['Employer ZIP'], ['Employer ZIP']) }} as Employer_ZIP,
    {{ json_extract_scalar('_airbyte_data', ['Payment Date'], ['Payment Date']) }} as Payment_Date,
    {{ json_extract_scalar('_airbyte_data', ['Recipient ID'], ['Recipient ID']) }} as Recipient_ID,
    {{ json_extract_scalar('_airbyte_data', ['Recur Weekly'], ['Recur Weekly']) }} as Recur_Weekly,
    {{ json_extract_scalar('_airbyte_data', ['Shipping Zip'], ['Shipping Zip']) }} as Shipping_Zip,
    {{ json_extract_scalar('_airbyte_data', ['Donor Country'], ['Donor Country']) }} as Donor_Country,
    {{ json_extract_scalar('_airbyte_data', ['Employer City'], ['Employer City']) }} as Employer_City,
    {{ json_extract_scalar('_airbyte_data', ['Fundraiser ID'], ['Fundraiser ID']) }} as Fundraiser_ID,
    {{ json_extract_scalar('_airbyte_data', ['Gift Declined'], ['Gift Declined']) }} as Gift_Declined,
    {{ json_extract_scalar('_airbyte_data', ['Recovery Date'], ['Recovery Date']) }} as Recovery_Date,
    {{ json_extract_scalar('_airbyte_data', ['Shipping City'], ['Shipping City']) }} as Shipping_City,
    {{ json_extract_scalar('_airbyte_data', ['Donor Employer'], ['Donor Employer']) }} as Donor_Employer,
    {{ json_extract_scalar('_airbyte_data', ['Employer Addr1'], ['Employer Addr1']) }} as Employer_Addr1,
    {{ json_extract_scalar('_airbyte_data', ['Employer Addr2'], ['Employer Addr2']) }} as Employer_Addr2,
    {{ json_extract_scalar('_airbyte_data', ['Employer State'], ['Employer State']) }} as Employer_State,
    {{ json_extract_scalar('_airbyte_data', ['Reference Code'], ['Reference Code']) }} as Reference_Code,
    {{ json_extract_scalar('_airbyte_data', ['Shipping Addr1'], ['Shipping Addr1']) }} as Shipping_Addr1,
    {{ json_extract_scalar('_airbyte_data', ['Shipping State'], ['Shipping State']) }} as Shipping_State,
    {{ json_extract_scalar('_airbyte_data', ['Disbursement ID'], ['Disbursement ID']) }} as Disbursement_ID,
    {{ json_extract_scalar('_airbyte_data', ['Donor Last Name'], ['Donor Last Name']) }} as Donor_Last_Name,
    {{ json_extract_scalar('_airbyte_data', ['Gift Identifier'], ['Gift Identifier']) }} as Gift_Identifier,
    {{ json_extract_scalar('_airbyte_data', ['Smart Recurring'], ['Smart Recurring']) }} as Smart_Recurring,
    {{ json_extract_scalar('_airbyte_data', ['Donor First Name'], ['Donor First Name']) }} as Donor_First_Name,
    {{ json_extract_scalar('_airbyte_data', ['Donor Occupation'], ['Donor Occupation']) }} as Donor_Occupation,
    {{ json_extract_scalar('_airbyte_data', ['Employer Country'], ['Employer Country']) }} as Employer_Country,
    {{ json_extract_scalar('_airbyte_data', ['Fundraising Page'], ['Fundraising Page']) }} as Fundraising_Page,
    {{ json_extract_scalar('_airbyte_data', ['Reference Code 2'], ['Reference Code 2']) }} as Reference_Code_2,
    {{ json_extract_scalar('_airbyte_data', ['Shipping Country'], ['Shipping Country']) }} as Shipping_Country,
    {{ json_extract_scalar('_airbyte_data', ['Disbursement Date'], ['Disbursement Date']) }} as Disbursement_Date,
    {{ json_extract_scalar('_airbyte_data', ['Recurrence Number'], ['Recurrence Number']) }} as Recurrence_Number,
    {{ json_extract_scalar('_airbyte_data', ['Smart Boost Shown'], ['Smart Boost Shown']) }} as Smart_Boost_Shown,
    {{ json_extract_scalar('_airbyte_data', ['New Express Signup'], ['New Express Signup']) }} as New_Express_Signup,
    {{ json_extract_scalar('_airbyte_data', ['Recipient Election'], ['Recipient Election']) }} as Recipient_Election,
    {{ json_extract_scalar('_airbyte_data', ['Smart Boost Amount'], ['Smart Boost Amount']) }} as Smart_Boost_Amount,
    {{ json_extract_scalar('_airbyte_data', ['Fundraising Partner'], ['Fundraising Partner']) }} as Fundraising_Partner,
    {{ json_extract_scalar('_airbyte_data', ['Recipient Committee'], ['Recipient Committee']) }} as Recipient_Committee,
    {{ json_extract_scalar('_airbyte_data', ['Text Message Opt In'], ['Text Message Opt In']) }} as Text_Message_Opt_In,
    {{ json_extract_scalar('_airbyte_data', ['ActBlue Express Lane'], ['ActBlue Express Lane']) }} as ActBlue_Express_Lane,
    {{ json_extract_scalar('_airbyte_data', ['Custom Field 1 Label'], ['Custom Field 1 Label']) }} as Custom_Field_1_Label,
    {{ json_extract_scalar('_airbyte_data', ['Custom Field 1 Value'], ['Custom Field 1 Value']) }} as Custom_Field_1_Value,
    {{ json_extract_scalar('_airbyte_data', ['ActBlue Express Donor'], ['ActBlue Express Donor']) }} as ActBlue_Express_Donor,
    {{ json_extract_scalar('_airbyte_data', ['Partner Contact Email'], ['Partner Contact Email']) }} as Partner_Contact_Email,
    {{ json_extract_scalar('_airbyte_data', ['Recurring Total Months'], ['Recurring Total Months']) }} as Recurring_Total_Months,
    {{ json_extract_scalar('_airbyte_data', ['Recurring Upsell Shown'], ['Recurring Upsell Shown']) }} as Recurring_Upsell_Shown,
    {{ json_extract_scalar('_airbyte_data', ['Fundraiser Recipient ID'], ['Fundraiser Recipient ID']) }} as Fundraiser_Recipient_ID,
    {{ json_extract_scalar('_airbyte_data', ['Weekly Recurring Amount'], ['Weekly Recurring Amount']) }} as Weekly_Recurring_Amount,
    {{ json_extract_scalar('_airbyte_data', ['Fundraiser Contact Email'], ['Fundraiser Contact Email']) }} as Fundraiser_Contact_Email,
    {{ json_extract_scalar('_airbyte_data', ['Monthly Recurring Amount'], ['Monthly Recurring Amount']) }} as Monthly_Recurring_Amount,
    {{ json_extract_scalar('_airbyte_data', ['Partner Contact Last Name'], ['Partner Contact Last Name']) }} as Partner_Contact_Last_Name,
    {{ json_extract_scalar('_airbyte_data', ['Partner Contact First Name'], ['Partner Contact First Name']) }} as Partner_Contact_First_Name,
    {{ json_extract_scalar('_airbyte_data', ['Recurring Upsell Succeeded'], ['Recurring Upsell Succeeded']) }} as Recurring_Upsell_Succeeded,
    {{ json_extract_scalar('_airbyte_data', ['Fundraiser Contact Last Name'], ['Fundraiser Contact Last Name']) }} as Fundraiser_Contact_Last_Name,
    {{ json_extract_scalar('_airbyte_data', ['Fundraiser Contact First Name'], ['Fundraiser Contact First Name']) }} as Fundraiser_Contact_First_Name,
    {{ json_extract_scalar('_airbyte_data', ['Card Replaced by Account Updater'], ['Card Replaced by Account Updater']) }} as Card_Replaced_by_Account_Updater,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('mailchimp', '_airbyte_raw_refunded_contributions_stream') }} as table_alias
-- refunded_contributions_stream
where 1 = 1

