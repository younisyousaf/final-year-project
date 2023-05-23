import { ReactNode } from "react";
import NavtrackLogo from "../../../assets/images/vtrack-white.png";
import { useIntl } from "react-intl";

interface ILoginLayoutProps {
  children: ReactNode;
}

export function LoginLayout(props: ILoginLayoutProps) {
  const intl = useIntl();

  return (
    <div className="flex min-h-screen flex-col bg-gray-100 p-8">
      <img
        className="mx-auto w-20"
        src={NavtrackLogo}
        alt={intl.formatMessage({ id: "vtrack" })}
      />
      {props.children}
    </div>
  );
}
