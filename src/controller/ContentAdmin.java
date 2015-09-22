package controller;

public class ContentAdmin {

	public ContentAdmin(String tutSubheading) {
		this.settutorialSubheading(tutSubheading);
		this.setTutContent(tutContent);
	}

	public String getTutContent() {
		return tutContent;
	}

	public void setTutContent(String tutContent) {
		this.tutContent = tutContent;
	}

	public ContentAdmin() {

	}

	private String tutSubheading;
	private String tutContent;

	public void settutorialSubheading(String tutSubheading) {
		this.tutSubheading = tutSubheading;
	}

	public String gettutorialSubheading() {
		return tutSubheading;
	}

}